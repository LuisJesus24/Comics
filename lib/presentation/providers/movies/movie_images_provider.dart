import 'package:comics/domain/entities/movie_images.dart';
import 'package:comics/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieImagesProvider =
    FutureProvider.family<MovieImages, int>(
  (ref, movieId) {

    final repository =
        ref.watch(movieRepositoryProvider);

    return repository.getMovieImages(movieId);
  },
);