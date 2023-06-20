import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'github_owner.g.dart';

@immutable
@JsonSerializable(fieldRename: FieldRename.snake)
class GithubOwner {
  const GithubOwner({this.avatarUrl, this.login});

  factory GithubOwner.fromJson(Map<String, dynamic> json) =>
      _$GithubOwnerFromJson(json);
  final String? avatarUrl;
  final String? login;

  Map<String, dynamic> toJson() => _$GithubOwnerToJson(this);

  GithubOwner copyWith({
    String? avatarUrl,
    String? login,
  }) =>
      GithubOwner(
        avatarUrl: avatarUrl ?? this.avatarUrl,
        login: login ?? this.login,
      );
}
