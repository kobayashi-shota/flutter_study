import '../model/get_latest_news_response.dart';
import 'news_api_datasource.dart';

class NewsApiDatasourceImpl implements NewsApiDatasource {
  NewsApiDatasourceImpl(this._datasource);

  final NewsApiDatasource _datasource;

  @override
  Future<GetLatestNewsResponse> getLatestNews(
    String? category,
    String? country,
    int? page,
    int? pageSize,
    String? query,
  ) async {
    final newData = await _datasource.getLatestNews(
      category,
      country,
      page,
      pageSize,
      query,
    );

    if (newData.status == 'ok') {
      return newData;
    } else {
      throw Exception('getTopHeadlines exception');
    }
  }
}
