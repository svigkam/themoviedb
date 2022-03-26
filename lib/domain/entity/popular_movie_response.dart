import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/movie.dart';

part 'popular_movie_response.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake, // for camelCase
  explicitToJson: true, // for movie json work
)
class PopularMovieResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<Movie> movies;
  final int totalResults;
  final int totalPages;

  PopularMovieResponse({
    required this.movies,
    required this.page,
    required this.totalPages,
    required this.totalResults,
  });
  factory PopularMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularMovieResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PopularMovieResponseToJson(this);
}
