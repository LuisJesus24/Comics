import 'package:comics/domain/entities/movie.dart';
import 'package:comics/domain/entities/movie_images.dart';
import 'package:comics/domain/repositories/movies_repository.dart';
import 'package:comics/infrastructure/datasources/moviedb_datasource.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviedbDatasource moviedbDatasource;

  MovieRepositoryImpl(this.moviedbDatasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return moviedbDatasource.getNowPlaying(page: page);
  }

  @override
  Future<MovieImages> getMovieImages(int movieId) {
    return moviedbDatasource.getMovieImages(movieId);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return moviedbDatasource.getPopular();
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return moviedbDatasource.getTopRated();
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return moviedbDatasource.getUpcoming();
  }
}
