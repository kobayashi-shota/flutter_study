import 'package:flutter/material.dart';
import 'package:flutter_study/application/use_case/delete_favorites_use_case_impl.dart';
import 'package:flutter_study/application/use_case/get_favorites_use_case_impl.dart';
import 'package:flutter_study/infra/datasource/favorites_datasource_impl.dart';
import 'package:flutter_study/infra/repository/favorites_repository_impl.dart';

import '../../../infra/model/article.dart';

class NewsFavoritesScreen extends StatefulWidget {
  const NewsFavoritesScreen({super.key});

  @override
  State<NewsFavoritesScreen> createState() => _NewsFavoritesScreenState();
}

class _NewsFavoritesScreenState extends State<NewsFavoritesScreen> {
  final getFavoritesUseCase = GetFavoritesUseCaseImpl(
    FavoritesRepositoryImpl(FavoritesDatasourceImpl()),
  );
  final deleteFavoriteUseCase = DeleteFavoritesUseCaseImpl(
    FavoritesRepositoryImpl(FavoritesDatasourceImpl()),
  );

  List<Article> favorites = [];

  @override
  void initState() {
    super.initState();
    loadPersonsFromJson();
  }

  Future<void> loadPersonsFromJson() async {
    final loadedFavorites = await getFavoritesUseCase.get();

    setState(() {
      favorites = loadedFavorites;
    });
  }

  void deletePerson(Article article) {
    setState(() {
      favorites.remove(article);
    });

    deleteFavoriteUseCase.delete(article);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('favorites'),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          if (favorites.isEmpty) {
            return const ListTile(title: Text('お気に入りはまだありません'));
          }

          return ListTile(
            title: Text(favorites[index].title),
            subtitle: Text(favorites[index].author.toString()),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deletePerson(favorites[index]),
            ),
          );
        },
      ),
    );
  }
}
