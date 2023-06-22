import 'package:flutter/material.dart';

import '../../core/constants/enums/news_category.dart';
import 'news_drawer_header.dart';

class NewsCategoryDrawer extends StatelessWidget {
  const NewsCategoryDrawer({super.key, required this.onTap});

  final void Function(NewsCategory) onTap;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    final categoryTiles = NewsCategory.values
        .map(
          (category) => ListTile(
            title: Text(category.name),
            onTap: () => onTap(category),
          ),
        )
        .toList();

    children
      ..add(const NewsDrawerHeader(headerTitle: 'News category'))
      ..addAll(categoryTiles);

    return Drawer(
      child: ListView(
        children: children,
      ),
    );
  }
}
