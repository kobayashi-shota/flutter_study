import '../../infra/model/article.dart';

abstract class PostFavoritesUseCase {
  Future<void> delete(Article article) {
    throw UnimplementedError();
  }
}
