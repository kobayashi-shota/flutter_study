import 'package:flutter_study/domain/repository/latest_news_repository.dart';
import 'package:flutter_study/infra/datasource/news_api_datasource.dart';
import 'package:flutter_study/infra/model/get_latest_news_response.dart';

class LatestNewsRepositoryImpl implements LatestNewsRepository {
  LatestNewsRepositoryImpl(this.datasource);

  final NewsApiDatasource datasource;

  @override
  Future<GetLatestNewsResponse> getTopHeadlines(
    String? category,
    String? country,
    int? page,
    int? pageSize,
    String? query,
  ) async {
    try {
      final newData = await datasource.getLatestNews(
        category,
        country,
        page,
        pageSize,
        query,
      );
      return newData;
    } on Exception {
      rethrow;
    }
  }
}
