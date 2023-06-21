import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/get_latest_news_response.dart';

part 'news_api_datasource.g.dart';

@RestApi(baseUrl: 'https://newsapi.org')
abstract class NewsApiDatasource {
  factory NewsApiDatasource(Dio dio, {String baseUrl}) = _NewsApiDatasource;

  @GET('/v2/top-headlines')
  Future<GetLatestNewsResponse> getLatestNews(
    @Query('category') String? category,
    @Query('country') String? country,
    @Query('page') int? page,
    @Query('pageSize') int? pageSize,
    @Query('q') String? query,
  );
}
