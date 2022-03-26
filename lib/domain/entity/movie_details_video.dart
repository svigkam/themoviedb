
import 'package:json_annotation/json_annotation.dart';

part 'movie_details_video.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsVideo {
  final int id;
  final List<Video> results;
  MovieDetailsVideo({
    required this.id,
    required this.results,
  });
  factory MovieDetailsVideo.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsVideoFromJson(json);
  Map<String, dynamic> toJson() => _$MovieDetailsVideoToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Video {
  @JsonKey(name: 'iso_639_1')
  final String isoFirst;
  @JsonKey(name: 'iso_3166_1')
  final String isoSecond;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String publishedAt;
  final String id;
  Video({
    required this.isoFirst,
    required this.isoSecond,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.publishedAt,
    required this.id,
  });
  factory Video.fromJson(Map<String, dynamic> json) =>
      _$VideoFromJson(json);
  Map<String, dynamic> toJson() => _$VideoToJson(this);
}
