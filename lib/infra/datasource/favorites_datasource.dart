import 'dart:io';

import '../model/article.dart';

abstract class FavoritesDatasource {
  Future<File> getFavoritesFile() {
    throw UnimplementedError();
  }

  Future<void> saveFavorites(List<Article> favorites) {
    throw UnimplementedError();
  }
}
