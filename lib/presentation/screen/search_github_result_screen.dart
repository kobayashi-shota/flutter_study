import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/domain/entity/github_repo.dart';
import 'package:flutter_study/network/clients/github_api_client.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SearchGithubResultScreen extends StatefulWidget {
  const SearchGithubResultScreen({super.key, required this.query});

  final String query;

  @override
  State<StatefulWidget> createState() => _SearchGithubResultScreenState();
}

class _SearchGithubResultScreenState extends State<SearchGithubResultScreen> {
  late final PagingController<int, GithubRepo> _pagingController;
  int currentPage = 1;
  bool isLoading = false;
  final List<GithubRepo> itemList = [];
  final dio = Dio();
  late final GithubApiClient client;

  Future<void> fetchItems() async {
    final newData = await client.getGitHubRepoList(widget.query, currentPage);
    setState(() {
      itemList.addAll(newData.items);
      currentPage++;
    });

    try {
      final hasNext = newData.items.isNotEmpty;
      if (hasNext) {
        _pagingController.appendPage(newData.items, currentPage);
      } else {
        _pagingController.appendLastPage(newData.items);
      }
    } on Exception catch (e) {
      _pagingController.error = e;
    }
  }

  @override
  void initState() {
    client = GithubApiClient(dio);
    _pagingController = PagingController(firstPageKey: currentPage);
    _pagingController.addPageRequestListener((pageKey) {
      fetchItems();
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
      appBar: AppBar(
        title: Text(
          '${widget.query}を含むリポジトリ',
          style: const TextStyle(fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: PagedListView<int, GithubRepo>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<GithubRepo>(
            itemBuilder: (context, repo, index) {
              return ListTile(
                title: Text(repo.name),
                subtitle: Text(repo.description ?? ''),
                leading: switch (repo.owner.avatarUrl) {
                  null => const Icon(Icons.account_circle),
                  final avatarUrl => CachedNetworkImage(
                      imageUrl: avatarUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                },
                trailing: Text('⭐️${repo.stargazersCount}'),
              );
            },
          ),
        ),
      ),
    );
  }
}
