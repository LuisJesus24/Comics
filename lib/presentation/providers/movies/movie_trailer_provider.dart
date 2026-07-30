import 'package:moviedb/domain/entities/movie_video.dart';
import 'package:moviedb/presentation/providers/movies/movies_repository_provider.dart';
import 'package:riverpod/legacy.dart';

final movieTrailerProvider =
    StateNotifierProvider<MovieTrailerNotifier, Map<String, MovieVideo?>>((ref) {
  final repository = ref.watch(movieRepositoryProvider);

  return MovieTrailerNotifier(getTrailer: repository.getMovieTrailer);
});

typedef GetMovieTrailerCallback = Future<MovieVideo?> Function(String movieId);

class MovieTrailerNotifier extends StateNotifier<Map<String, MovieVideo?>> {
  final GetMovieTrailerCallback getTrailer;

  MovieTrailerNotifier({required this.getTrailer}) : super({});

  Future<void> loadTrailer(String movieId) async {
    if (state[movieId] != null) return;

    final trailer = await getTrailer(movieId);

    state = {...state, movieId: trailer};
  }
}
