import 'package:comics/config/constants/environment.dart';
import 'package:comics/domain/datasources/movies_datasource.dart';
import 'package:comics/domain/entities/movie.dart';
import 'package:comics/domain/entities/movie_images.dart';
import 'package:comics/infrastructure/mappers/movie_images_mapper.dart';
import 'package:comics/infrastructure/mappers/movie_mapper.dart';
import 'package:comics/infrastructure/models/moviedb/movie_images_response.dart';
import 'package:comics/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
      },
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath != 'no poster')
        .map((moviedb) => MovieMapper.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<MovieImages> getMovieImages(int movieId) async {

    final response = await dio.get(
      '/movie/$movieId/images',
    );

    final imagesResponse = MovieImagesResponse.fromJson(response.data);

    return MovieImagesMapper.toEntity(imagesResponse);
  }
}
