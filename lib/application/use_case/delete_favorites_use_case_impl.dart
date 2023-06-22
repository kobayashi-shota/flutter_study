import 'package:flutter_study/domain/use_case/delete_favorite_use_case.dart';
import 'package:flutter_study/infra/model/article.dart';
import 'package:flutter_study/infra/repository/favorites_repository_impl.dart';

class DeleteFavoritesUseCaseImpl implements DeleteFavoritesUseCase {
  DeleteFavoritesUseCaseImpl(this._repository);

  final FavoritesRepositoryImpl _repository;

  @override
  Future<void> delete(Article article) async {
    await _repository.removeFavorite(article);
  }
}
