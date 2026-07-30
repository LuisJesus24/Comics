import 'package:moviedb/config/constants/environment.dart';
import 'package:moviedb/domain/datasources/movies_datasource.dart';
import 'package:moviedb/domain/entities/movie.dart';
import 'package:moviedb/domain/entities/movie_images.dart';
import 'package:moviedb/domain/entities/movie_video.dart';
import 'package:moviedb/infrastructure/mappers/movie_images_mapper.dart';
import 'package:moviedb/infrastructure/mappers/movie_mapper.dart';
import 'package:moviedb/infrastructure/models/moviedb/movie_details.dart';
import 'package:moviedb/infrastructure/models/moviedb/movie_images_response.dart';
import 'package:moviedb/infrastructure/models/moviedb/movie_moviedb.dart';
import 'package:moviedb/infrastructure/models/moviedb/movie_videos_response.dart';
import 'package:moviedb/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Environment.theMovieDbKey},
    ),
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing');

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath.isNotEmpty)
        .map((moviedb) => MovieMapper.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<MovieImages> getMovieImages(String movieId) async {
    final response = await dio.get('/movie/$movieId/images');

    final imagesResponse = MovieImagesResponse.fromJson(response.data);

    return MovieImagesMapper.toEntity(imagesResponse);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular');

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath.isNotEmpty)
        .map((moviedb) => MovieMapper.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated');

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath.isNotEmpty)
        .map((moviedb) => MovieMapper.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming');

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath.isNotEmpty)
        .map((moviedb) => MovieMapper.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }

  @override
  Future<Movie> getMovieById(String movieId) async {
    final response = await dio.get('/movie/$movieId');

    if (response.statusCode != 200)
      throw Exception('movie with id: $movieId not found');

    final movieDbResponse = MovieDetails.fromJson(response.data);

    return MovieMapper.movieDetailsToEntity(movieDbResponse);
  }

  @override
  Future<MovieVideo?> getMovieTrailer(String movieId) async {
    final response = await dio.get('/movie/$movieId/videos');

    final videosResponse = MovieVideosResponse.fromJson(response.data);

    final trailer = videosResponse.results.where((video) {
      return video.site.toLowerCase() == 'youtube' &&
          video.type.toLowerCase() == 'trailer';
    }).toList();

    if (trailer.isEmpty) {
      return null;
    }

    return trailer.first;
  }

  @override
  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    final response = await dio.get(
      '/search/movie',
      queryParameters: {'query': query, 'page': page},
    );

    final movieDbResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDbResponse.results
        .where((moviedb) => moviedb.posterPath.isNotEmpty)
        .map((moviedb) => MovieMapper.movieDbToEntity(moviedb))
        .toList();

    return movies;
  }
}
