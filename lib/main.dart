import 'package:flutter/material.dart';
import 'package:flutter_study/presentation/screen/count_up_screen.dart';
import 'package:flutter_study/presentation/screen/search_books_top_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Count Up',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SearchBooksTopScreen(),
    );
  }
}
