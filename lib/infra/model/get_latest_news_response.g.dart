// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_latest_news_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLatestNewsResponse _$GetLatestNewsResponseFromJson(
        Map<String, dynamic> json) =>
    GetLatestNewsResponse(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int?,
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: json['code'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetLatestNewsResponseToJson(
        GetLatestNewsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
      'code': instance.code,
      'message': instance.message,
    };
