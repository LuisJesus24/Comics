import 'package:comics/config/constants/environment.dart';
import 'package:comics/domain/datasources/movies_datasource.dart';
import 'package:comics/domain/entities/movie.dart';
import 'package:comics/infrastructure/mappers/movie_mapper.dart';
import 'package:comics/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-MX',
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');

    if (response.data == null) return [];

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .map((moviedb) => MovieMapper.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }
}
