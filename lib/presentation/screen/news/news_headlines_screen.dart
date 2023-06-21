import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/application/use_case/get_latest_news_use_case_impl.dart';
import 'package:flutter_study/core/constants/enums/country_code.dart';
import 'package:flutter_study/core/constants/enums/news_category.dart';
import 'package:flutter_study/core/exceptions/app_exception.dart';
import 'package:flutter_study/core/util/show_snack_bar.dart';
import 'package:flutter_study/infra/datasource/news_api_datasource.dart';
import 'package:flutter_study/infra/datasource/news_api_datasource_impl.dart';
import 'package:flutter_study/infra/model/article.dart';
import 'package:flutter_study/infra/repository/latest_news_repository_impl.dart';
import 'package:flutter_study/presentation/component/country_drawer.dart';
import 'package:flutter_study/presentation/component/news_category_drawer.dart';
import 'package:flutter_study/presentation/screen/webview_screen.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../application/use_case/post_favorites_use_case_impl.dart';
import '../../../infra/datasource/favorites_datasource_impl.dart';
import '../../../infra/repository/favorites_repository_impl.dart';

class NewsHeadlinesScreen extends StatefulWidget {
  const NewsHeadlinesScreen({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _NewsHeadlinesScreenState();
}

class _NewsHeadlinesScreenState extends State<NewsHeadlinesScreen> {
  final postFavoriteUseCase = PostFavoritesUseCaseImpl(
    FavoritesRepositoryImpl(FavoritesDatasourceImpl()),
  );
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late final PagingController<int, Article> _pagingController;
  final defaultPage = 1;
  NewsCategory _selectedCategory = NewsCategory.sports;
  Country _selectedCountry = Country.japan;
  int currentPage = 1;
  bool isLoading = false;
  final _dio = Dio();
  late final GetLatestNewsUseCaseImpl _useCase;

  Future<void> fetchItems(int page) async {
    try {
      final newData = await _useCase.get(
        _selectedCategory.name,
        _selectedCountry.alpha2code,
        currentPage,
        null,
        null,
      );

      setState(() {
        currentPage++;
      });

      switch (newData.articles) {
        case final article?:
          article.isNotEmpty
              ? _pagingController.appendPage(
                  article,
                  currentPage,
                )
              : _pagingController.appendLastPage(article);
        case null:
          break;
      }
    } on Exception catch (e) {
      _pagingController.error = e;
    }
  }

  void _refresh() {
    setState(() {
      currentPage = defaultPage;
    });
    _pagingController.refresh();
  }

  void _refreshWithDrawer(Object item) {
    Navigator.pop(context);
    switch (item) {
      case final Country country:
        setState(() {
          _selectedCountry = country;
        });
      case final NewsCategory category:
        setState(() {
          _selectedCategory = category;
        });
      default:
        break;
    }
    _refresh();
  }

  @override
  void initState() {
    const newsApiKey = String.fromEnvironment('NEWSAPI_KEY');

    if (newsApiKey.isEmpty) {
      throw AssertionError('NEWSAPI_KEY is not set');
    }

    _dio.options.headers['X-Api-Key'] = newsApiKey;

    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));

    _useCase = GetLatestNewsUseCaseImpl(
      LatestNewsRepositoryImpl(
        NewsApiDatasourceImpl(
          NewsApiDatasource(_dio),
        ),
      ),
    );

    _pagingController = PagingController(firstPageKey: currentPage);

    _pagingController.addPageRequestListener((pageKey) {
      fetchItems(currentPage);
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          _selectedCountry.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.replay,
              color: Colors.white,
            ),
            tooltip: 'refresh top-headlines',
            onPressed: _refresh,
          ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: const Icon(Icons.public),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          _refresh,
        ),
        child: PagedListView<int, Article>.separated(
          separatorBuilder: (context, _) => const Divider(),
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<Article>(
            itemBuilder: (context, article, _) {
              return ListTile(
                title: Text(article.title),
                subtitle: Text(article.author ?? ''),
                trailing: article.urlToImage != null
                    ? CachedNetworkImage(
                        imageUrl: article.urlToImage!,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : null,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => WebViewScreen(
                        url: article.url,
                      ),
                    ),
                  );
                },
                onLongPress: () async {
                  // use_build_context_synchronously対策
                  final isMounted = context.mounted;
                  final scaffoldMessenger = ScaffoldMessenger.of(context);

                  try {
                    await postFavoriteUseCase.post(article);
                    if (!isMounted) {
                      return;
                    }
                    showSnackBar(
                      scaffoldMessenger,
                      'お気に入りに追加しました\n${article.title}\n${article.author}',
                    );
                  } on AlreadyExistsException catch (e) {
                    showSnackBar(
                      scaffoldMessenger,
                      '${e.message}\n${article.title}\n${article.author}',
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
      drawer: NewsCategoryDrawer(
        onTap: _refreshWithDrawer,
      ),
      endDrawer: CountryDrawer(
        onTap: _refreshWithDrawer,
      ),
    );
  }
}
