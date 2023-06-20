// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubRepo _$GithubRepoFromJson(Map<String, dynamic> json) => GithubRepo(
      description: json['description'] as String?,
      name: json['name'] as String,
      owner: GithubOwner.fromJson(json['owner'] as Map<String, dynamic>),
      stargazersCount: json['stargazers_count'] as int,
    );

Map<String, dynamic> _$GithubRepoToJson(GithubRepo instance) =>
    <String, dynamic>{
      'description': instance.description,
      'name': instance.name,
      'owner': instance.owner,
      'stargazers_count': instance.stargazersCount,
    };
