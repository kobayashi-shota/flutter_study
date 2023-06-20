import 'package:flutter/cupertino.dart';
import 'package:flutter_study/domain/entity/github_repo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_github_repo_response.g.dart';

@immutable
@JsonSerializable()
class GetGitHubRepoResponse {
  const GetGitHubRepoResponse({required this.items});

  factory GetGitHubRepoResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GetGitHubRepoResponseFromJson(json);

  final List<GithubRepo> items;

  GetGitHubRepoResponse copyWith({
    required List<GithubRepo>? items,
  }) =>
      GetGitHubRepoResponse(
        items: items ?? this.items,
      );
}
