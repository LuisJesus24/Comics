import 'package:comics/domain/entities/movie.dart';
import 'package:comics/domain/entities/movie_images.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});

   Future<MovieImages> getMovieImages(int movieId);
}
