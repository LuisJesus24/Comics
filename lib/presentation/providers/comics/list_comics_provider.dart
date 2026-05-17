import 'package:comics/domain/entities/comic.dart';
import 'package:comics/presentation/providers/comics/comic_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/legacy.dart';

final searchComicsListProvider =
    StateNotifierProvider<ComicsNotifier, List<Comic>>((ref) {
      return ComicsNotifier(
        fetchMoreComics: ({int page = 1}) {
          return ref.watch(repositoryProvider).getPopularComics();
        },
      );
    });

typedef ComicsCallback = Future<List<Comic>> Function({int page});

class ComicsNotifier extends StateNotifier<List<Comic>> {
  int currentPage = 0;
  ComicsCallback? fetchMoreComics;

  ComicsNotifier({required this.fetchMoreComics}) : super([]);

  Future<void> loadNextPage() async {
    currentPage++;
    final List<Comic> comics = await fetchMoreComics!(page: currentPage);
    state = [...state, ...comics];
  }
}
