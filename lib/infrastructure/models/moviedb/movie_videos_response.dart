import 'package:moviedb/domain/entities/movie_video.dart';

class MovieVideosResponse {
  final List<MovieVideo> results;

  MovieVideosResponse({required this.results});

  factory MovieVideosResponse.fromJson(Map<String, dynamic> json) {
    final results = (json['results'] as List<dynamic>?)
            ?.map((e) => MovieVideo.fromJson(e as Map<String, dynamic>))
            .toList() ??
        <MovieVideo>[];

    return MovieVideosResponse(results: results);
  }
}
