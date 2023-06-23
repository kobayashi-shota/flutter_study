import '../../infra/model/get_latest_news_response.dart';

abstract class GetLatestNewsUseCase {
  Future<GetLatestNewsResponse> get(
    String? category,
    String? country,
    int? page,
    int? pageSize,
    String? query,
  ) {
    throw UnimplementedError();
  }
}
