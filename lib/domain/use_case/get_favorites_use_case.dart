import '../../infra/model/article.dart';

abstract class GetFavoritesUseCase {
  Future<List<Article>> get() {
    throw UnimplementedError();
  }
}
