import 'package:comics/domain/entities/comic.dart';
import 'package:comics/domain/repositories/comics_repository.dart';
import 'package:comics/infrastructure/datasources/comic_vine_datasource.dart';
import 'package:comics/infrastructure/repositories/comic_vine_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final repositoryProvider = Provider<ComicsRepository>((ref) {
  return ComicVineRepositories(datasource: ComicVineDatasource());
});

final comicProvider = FutureProvider.family<Comic, int>((ref, id) {
  final repository = ref.watch(repositoryProvider);
  return repository.getComic(id);
});

final popularComicsProvider = FutureProvider<List<Comic>>((ref) {
  final repository = ref.watch(repositoryProvider);
  return repository.getPopularComics();
});

final searchQueryProvider = StateProvider<String>((ref) {
  return '';
});

final searchComicsProvider = FutureProvider.family<List<Comic>, String>((
  ref,
  query,
) {
  final repository = ref.watch(repositoryProvider);
  return repository.searchComics(query);
});
