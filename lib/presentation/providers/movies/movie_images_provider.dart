import 'package:comics/domain/entities/movie_images.dart';
import 'package:comics/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';

final movieImagesProvider =
    StateNotifierProvider<ImageMovieNotifier, Map<String, MovieImages>>((ref) {
      final imageMovie = ref.watch(movieRepositoryProvider);

      return ImageMovieNotifier(imageMovie: imageMovie.getMovieImages);
    });

typedef ImageMovieCallback = Future<MovieImages> Function(String movieId);

class ImageMovieNotifier extends StateNotifier<Map<String, MovieImages>> {
  final ImageMovieCallback imageMovie;

  ImageMovieNotifier({required this.imageMovie}) : super({});

  Future<void> imageOfMovies(String movieId) async {
    if (state.containsKey(movieId)) return;

    final images = await imageMovie(movieId);

    state = {...state, movieId: images};
  }
}
