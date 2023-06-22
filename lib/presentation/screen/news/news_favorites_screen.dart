import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/application/use_case/delete_favorites_use_case_impl.dart';
import 'package:flutter_study/application/use_case/get_favorites_use_case_impl.dart';
import 'package:flutter_study/infra/datasource/favorites_datasource_impl.dart';
import 'package:flutter_study/infra/repository/favorites_repository_impl.dart';

import '../../../infra/model/article.dart';
import '../webview_screen.dart';

class NewsFavoritesScreen extends StatefulWidget {
  const NewsFavoritesScreen({super.key, required this.title});

  final String title;

  @override
  State<NewsFavoritesScreen> createState() => _NewsFavoritesScreenState();
}

class _NewsFavoritesScreenState extends State<NewsFavoritesScreen>
    with SingleTickerProviderStateMixin {
  final getFavoritesUseCase = GetFavoritesUseCaseImpl(
    FavoritesRepositoryImpl(FavoritesDatasourceImpl()),
  );
  final deleteFavoriteUseCase = DeleteFavoritesUseCaseImpl(
    FavoritesRepositoryImpl(FavoritesDatasourceImpl()),
  );

  late final AnimationController controller;

  List<Article> favorites = [];
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    loadPersonsFromJson();
  }

  Future<void> loadPersonsFromJson() async {
    final loadedFavorites = await getFavoritesUseCase.get();

    setState(() {
      favorites = loadedFavorites;
    });
  }

  void deleteFavorite(Article article) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('お気に入りの削除'),
          content: Text('${article.title}を削除しますか？'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  favorites.remove(article);
                });

                deleteFavoriteUseCase.delete(article);

                final snackBar = SnackBar(
                  content: Text(
                    'お気に入りから削除しました\n${article.title}\n${article.author}',
                  ),
                );

                ScaffoldMessenger.of(context).showSnackBar(snackBar);

                Navigator.pop(context);
              },
              child: const Text(
                '削除',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            icon: switch (_isEditing) {
              true => const Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              false => const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
            },
          )
        ],
        backgroundColor: Colors.pink,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: switch (favorites.isEmpty) {
        true => const ListTile(
            title: Text('お気に入りはまだありません'),
          ),
        false => ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final favorite = favorites[index];

              return ListTile(
                title: Text(favorite.title),
                subtitle: Text(favorite.author.toString()),
                leading: AnimatedCrossFade(
                  alignment: Alignment.center,
                  crossFadeState: _isEditing
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: IconButton(
                    icon: const Icon(
                      Icons.remove_circle,
                    ),
                    color: Colors.redAccent,
                    onPressed: () => deleteFavorite(favorite),
                  ),
                  secondChild: const SizedBox.shrink(),
                  duration: const Duration(seconds: 1),
                  firstCurve: Curves.easeOutExpo,
                  secondCurve: Curves.easeInExpo,
                  sizeCurve: Curves.easeOutExpo,
                ),
                trailing: switch (favorite.urlToImage) {
                  final urlToImage? => CachedNetworkImage(
                      imageUrl: urlToImage,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  _ => const Icon(Icons.image),
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => WebViewScreen(
                        url: favorite.url,
                      ),
                    ),
                  );
                },
              );
            },
          ),
      },
    );
  }
}
