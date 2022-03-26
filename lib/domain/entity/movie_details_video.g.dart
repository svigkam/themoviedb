// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailsVideo _$MovieDetailsVideoFromJson(Map<String, dynamic> json) =>
    MovieDetailsVideo(
      id: json['id'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => Video.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieDetailsVideoToJson(MovieDetailsVideo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'results': instance.results.map((e) => e.toJson()).toList(),
    };

Video _$VideoFromJson(Map<String, dynamic> json) => Video(
      isoFirst: json['iso_639_1'] as String,
      isoSecond: json['iso_3166_1'] as String,
      name: json['name'] as String,
      key: json['key'] as String,
      site: json['site'] as String,
      size: json['size'] as int,
      type: json['type'] as String,
      official: json['official'] as bool,
      publishedAt: json['published_at'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'iso_639_1': instance.isoFirst,
      'iso_3166_1': instance.isoSecond,
      'name': instance.name,
      'key': instance.key,
      'site': instance.site,
      'size': instance.size,
      'type': instance.type,
      'official': instance.official,
      'published_at': instance.publishedAt,
      'id': instance.id,
    };
