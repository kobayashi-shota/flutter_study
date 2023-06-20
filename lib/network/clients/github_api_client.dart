import 'package:dio/dio.dart';
import 'package:flutter_study/domain/entity/get_github_repo_response.dart';
import 'package:retrofit/retrofit.dart';

part 'github_api_client.g.dart';

@RestApi(baseUrl: 'https://api.github.com')
abstract class GithubApiClient {
  factory GithubApiClient(Dio dio, {String baseUrl}) = _GithubApiClient;

  @GET('/search/repositories')
  Future<GetGitHubRepoResponse> getGitHubRepoList(
    @Query('q') String query,
    @Query('page') int page,
  );
}
