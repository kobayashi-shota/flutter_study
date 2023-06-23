import '../../infra/model/article.dart';

abstract class DeleteFavoritesUseCase {
  Future<void> delete(Article article) {
    throw UnimplementedError();
  }
}
