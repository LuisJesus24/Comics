import 'package:comics/domain/datasources/actors_datasources.dart';
import 'package:comics/domain/entities/actor.dart';
import 'package:comics/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository {
  final ActorsDatasources datasources;

  ActorRepositoryImpl(this.datasources);

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return datasources.getActorsByMovie(movieId);
  }
}
