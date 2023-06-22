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

  @JsonKey(defaultValue: '')
  final String? name;
  @JsonKey(defaultValue: '')
  final String? author;
  final String title;
  final String publishedAt;
  final String url;
  @JsonKey(defaultValue: '')
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

  // 以下のoverrideはインスタンス内のプロパティが一致する場合
  // contains==trueするため
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    return other is Article &&
        other.name == name &&
        other.author == author &&
        other.title == title &&
        other.publishedAt == publishedAt &&
        other.url == url &&
        other.urlToImage == urlToImage;
  }

  @override
  int get hashCode =>
      name.hashCode ^
      author.hashCode ^
      title.hashCode ^
      publishedAt.hashCode ^
      url.hashCode ^
      urlToImage.hashCode;
}
