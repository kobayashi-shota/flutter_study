import '../../infra/model/article.dart';

abstract class PostFavoritesUseCase {
  Future<void> post(Article article) {
    throw UnimplementedError();
  }
}
