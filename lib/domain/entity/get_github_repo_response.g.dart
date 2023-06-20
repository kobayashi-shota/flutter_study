// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_github_repo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetGitHubRepoResponse _$GetGitHubRepoResponseFromJson(
        Map<String, dynamic> json) =>
    GetGitHubRepoResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => GithubRepo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetGitHubRepoResponseToJson(
        GetGitHubRepoResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
