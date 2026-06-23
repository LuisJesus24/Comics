import 'package:moviedb/domain/datasources/actors_datasources.dart';
import 'package:moviedb/domain/entities/actor.dart';
import 'package:moviedb/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasources datasources;

  ActorRepositoryImpl(this.datasources);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasources.getActorsByMovie(movieId);
  }
}
