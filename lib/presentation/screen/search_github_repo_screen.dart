import 'package:flutter/material.dart';
import 'package:flutter_study/presentation/screen/search_github_result_screen.dart';

class SearchGithubHomeScreen extends StatefulWidget {
  const SearchGithubHomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchGithubHomeScreenState();
}

class _SearchGithubHomeScreenState extends State<SearchGithubHomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final _searchedList = <String>[];

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: SafeArea(
        child: TextField(
          controller: _textEditingController,
          decoration: const InputDecoration(label: Text('GitHubでリポジトリを検索')),
          onSubmitted: (String text) {
            _searchedList.add(text);
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => SearchGithubResultScreen(
                  query: text.trim(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
