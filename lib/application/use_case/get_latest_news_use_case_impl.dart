import 'package:flutter_study/domain/use_case/get_latest_news_use_case.dart';
import 'package:flutter_study/infra/model/get_latest_news_response.dart';
import 'package:flutter_study/infra/repository/latest_news_repository_impl.dart';

class GetLatestNewsUseCaseImpl implements GetLatestNewsUseCase {
  GetLatestNewsUseCaseImpl(this._repository);

  final LatestNewsRepositoryImpl _repository;

  @override
  Future<GetLatestNewsResponse> get(
    String? category,
    String? country,
    int? page,
    int? pageSize,
    String? query,
  ) async {
    return _repository.getTopHeadlines(
      category,
      country,
      page,
      pageSize,
      query,
    );
  }
}
