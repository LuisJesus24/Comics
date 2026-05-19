import 'package:comics/domain/entities/movie.dart';
import 'package:comics/domain/repositories/movies_repository.dart';
import 'package:comics/infrastructure/datasources/moviedb_datasource.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviedbDatasource moviedbDatasource;

  MovieRepositoryImpl(this.moviedbDatasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return moviedbDatasource.getNowPlaying(page: page);
  }
}
