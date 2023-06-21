import 'package:flutter_study/domain/use_case/get_favorites_use_case.dart';
import 'package:flutter_study/infra/model/article.dart';
import 'package:flutter_study/infra/repository/favorites_repository_impl.dart';

class GetFavoritesUseCaseImpl implements GetFavoritesUseCase {
  GetFavoritesUseCaseImpl(this._repository);

  final FavoritesRepositoryImpl _repository;

  @override
  Future<List<Article>> get() async {
    return _repository.getFavorites();
  }
}
