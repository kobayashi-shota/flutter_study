import 'package:flutter/cupertino.dart';
import 'package:flutter_study/domain/entity/github_owner.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_repo.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class GithubRepo {
  const GithubRepo({
    this.description,
    required this.name,
    required this.owner,
    required this.stargazersCount,
  });

  factory GithubRepo.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoFromJson(json);
  final String? description;
  final String name;
  final GithubOwner owner;
  final int stargazersCount;

  Map<String, dynamic> toJson() => _$GithubRepoToJson(this);

  GithubRepo copyWith({
    String? description,
    required String? name,
    required GithubOwner? owner,
    required int? stargazersCount,
  }) =>
      GithubRepo(
        description: description ?? this.description,
        name: name ?? this.name,
        owner: owner ?? this.owner,
        stargazersCount: stargazersCount ?? this.stargazersCount,
      );
}
