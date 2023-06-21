import 'package:flutter/cupertino.dart';
import 'package:flutter_study/infra/model/article.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_latest_news_response.g.dart';

@immutable
@JsonSerializable()
class GetLatestNewsResponse {
  const GetLatestNewsResponse({
    required this.status,
    this.totalResults,
    this.articles,
    this.code,
    this.message,
  });

  factory GetLatestNewsResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$GetLatestNewsResponseFromJson(json);

  final String status;
  final int? totalResults;
  final List<Article>? articles;
  final String? code;
  final String? message;

  GetLatestNewsResponse copyWith() => GetLatestNewsResponse(
        status: status,
        totalResults: totalResults,
        articles: articles,
        code: code,
        message: message,
      );
}
