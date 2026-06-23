import 'package:comics/domain/entities/movie.dart';
import 'package:comics/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/legacy.dart';




final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;

      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;

      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
      final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;

      return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
    });

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider =
    StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {
      final searchCallback = ref.watch(movieRepositoryProvider).searchMovies;

      return SearchMoviesNotifier(searchMovies: searchCallback);
    });



typedef MovieCallback = Future<List<Movie>> Function({int page});
typedef SearchCallback = Future<List<Movie>> Function(String query, {int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadnextPage() async {
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    print('Loaded ${movies.length} movies for page $currentPage'); // 👈
    state = [...state, ...movies];
  }
}

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {
  SearchCallback searchMovies;
  int currentPage = 0;
  String lastQuery = '';

  SearchMoviesNotifier({required this.searchMovies}) : super([]);

  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = [];
      currentPage = 0;
      lastQuery = '';
      return;
    }

    if (query != lastQuery) {
      currentPage = 0;
      lastQuery = query;
    }

    currentPage++;

    try {
      final List<Movie> movies = await searchMovies(query, page: currentPage);
      
      if (currentPage == 1) {
        state = movies;
      } else {
        state = [...state, ...movies];
      }
    } catch (e) {
      print('Error searching movies: $e');
      rethrow;
    }
  }

  void reset() {
    state = [];
    currentPage = 0;
    lastQuery = '';
  }
}
