import 'package:flutter/material.dart';

import 'news_favorites_screen.dart';
import 'news_headlines_screen.dart';

class NewsTopScreen extends StatefulWidget {
  const NewsTopScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewsTopScreenState();
}

class _NewsTopScreenState extends State<NewsTopScreen>
    with SingleTickerProviderStateMixin {
  static const List<Widget> screens = [
    NewsHeadlinesScreen(),
    NewsFavoritesScreen(),
  ];

  static const List<Tab> tabs = [
    Tab(
      text: 'トップ',
      icon: Icon(Icons.home),
    ),
    Tab(
      text: 'お気に入り',
      icon: Icon(Icons.favorite),
    ),
  ];

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: screens,
      ),
      bottomNavigationBar: SafeArea(
        child: TabBar(
          dividerColor: Colors.transparent,
          controller: _tabController,
          tabs: tabs,
        ),
      ),
    );
  }
}
