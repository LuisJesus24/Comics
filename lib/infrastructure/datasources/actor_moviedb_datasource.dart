import 'package:moviedb/config/constants/environment.dart';
import 'package:moviedb/domain/datasources/actors_datasources.dart';
import 'package:moviedb/domain/entities/actor.dart';
import 'package:moviedb/infrastructure/mappers/actor_mapper.dart';
import 'package:moviedb/infrastructure/models/moviedb/credits_reponse.dart';
import 'package:dio/dio.dart';

class ActorMoviedbDatasource extends ActorsDatasources {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3/movie/',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language': 'es-Mx',
      },
    ),
  );

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('$movieId/credits');

    if (response.statusCode != 200)
      throw Exception('movie with id: $movieId not found');

    final credits = CreditsResponse.fromJson(response.data);

    return credits.cast
        .map((actor) => ActorMapper.castToEntity(actor))
        .toList();
  }
}
