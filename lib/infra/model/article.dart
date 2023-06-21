import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article.g.dart';

@immutable
@JsonSerializable()
class Article {
  const Article({
    this.name,
    this.author,
    required this.title,
    required this.url,
    required this.publishedAt,
    this.urlToImage,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  final String? name;
  final String? author;
  final String title;
  final String publishedAt;
  final String url;
  final String? urlToImage;

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  Article copyWith() => Article(
        name: name,
        author: author,
        title: title,
        publishedAt: publishedAt,
        url: url,
        urlToImage: urlToImage,
      );
}
