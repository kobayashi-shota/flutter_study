import 'package:flutter/material.dart';

class SearchBooksTopScreen extends StatefulWidget {
  const SearchBooksTopScreen({super.key});

  @override
  State<StatefulWidget> createState() => SearchBooksTopScreenState();
}

class SearchBooksTopScreenState extends State<SearchBooksTopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('書籍検索'),
      ),
      body: const SafeArea(
        child: Center(
          child: Text(
            'ボタンをタップするとカメラが起動して\nISBNコードをスキャンできます',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.camera),
      ),
    );
  }
}
