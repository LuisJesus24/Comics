import 'package:moviedb/domain/entities/movie.dart';
import 'package:moviedb/presentation/providers/movies/movies_repository_provider.dart';
import 'package:riverpod/legacy.dart';

final movieInfoProvider = StateNotifierProvider<MovieMapNotifier,Map<String, Movie>>((ref) {
  final getMovie = ref.watch(movieRepositoryProvider);

  return MovieMapNotifier(getMovie: getMovie.getMovieById);
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;

  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    print('Realizando peticion http');

    final movie = await getMovie(movieId);

    state = {...state, movieId: movie};
  }
}
