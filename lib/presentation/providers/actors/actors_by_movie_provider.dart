import 'package:moviedb/domain/entities/actor.dart';
import 'package:moviedb/presentation/providers/actors/actors_repository_provider.dart';
import 'package:riverpod/legacy.dart';

final actorsByMovieProvider = StateNotifierProvider<ActorsByMovieNotifier,Map<String, List<Actor>>>((ref) {
  final getActors = ref.watch(actorsRepositoryProvider);

  return ActorsByMovieNotifier(getActors: getActors.getActorsByMovie);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  final GetActorsCallback getActors;

  ActorsByMovieNotifier({required this.getActors}) : super({});

  Future<void> loadActos(String movieId) async {
    if (state[movieId] != null) return;

    print('Realizando peticion http');

    final actors = await getActors(movieId);

    state = {...state, movieId: actors};
  }
}
