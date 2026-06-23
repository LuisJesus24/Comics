import 'package:moviedb/domain/entities/movie.dart';
import 'package:moviedb/domain/repositories/local_storage_repository.dart';
import 'package:moviedb/presentation/providers/storage/local_storage_provider.dart';
import 'package:riverpod/legacy.dart';

final favoriteMoviesprovider = StateNotifierProvider<StorageMoviesNotifier, Map<int, Movie>>((ref) {
  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return StorageMoviesNotifier(localStorageRepository: localStorageRepository);
});

class StorageMoviesNotifier extends StateNotifier<Map<int, Movie>> {
  int page = 0;
  final LocalStorageRepository localStorageRepository;

  StorageMoviesNotifier({required this.localStorageRepository}) : super({});

  Future<List<Movie>> loadNextPage() async {
    final movies = await localStorageRepository.loadFavoriteMovies(
      limit: 10,
      offset: page * 10,
    );

    page++;

    final tempMovies = <int, Movie>{};

    for (final movie in movies) {
      tempMovies[movie.id] = movie;
    }

    state = {...state, ...tempMovies};

    return movies;
  }

  Future<void> toggleFavoriteMovie(Movie movie) async {
    final isFavorite = await localStorageRepository.isFavoriteMovie(movie.id);

    await localStorageRepository.toggleFavoriteMovie(movie);

    if (isFavorite) {
      state.remove(movie.id);
      state = {...state};
      return;
    } else {
      state = {...state, movie.id: movie};
    }

    await localStorageRepository.toggleFavoriteMovie(movie);
  }
}
