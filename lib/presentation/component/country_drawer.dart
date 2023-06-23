import 'package:flutter/material.dart';
import 'package:flutter_study/core/constants/enums/country_code.dart';

import 'news_drawer_header.dart';

class CountryDrawer extends StatelessWidget {
  const CountryDrawer({super.key, required this.onTap});

  final void Function(Country) onTap;

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    final List<Widget> countryTiles = Country.values
        .map(
          (country) => ListTile(
            title: Text(country.name),
            onTap: () => onTap(country),
          ),
        )
        .toList();

    children
      ..add(const NewsDrawerHeader(headerTitle: 'Country'))
      ..addAll(countryTiles);

    return Drawer(
      child: ListView(
        children: children,
      ),
    );
  }
}
