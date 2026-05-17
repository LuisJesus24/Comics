import 'package:comics/domain/entities/comic.dart';
import 'package:comics/domain/repositories/comics_repository.dart';
import 'package:comics/infrastructure/datasources/comic_vine_datasource.dart';

class ComicVineRepositories extends ComicsRepository {
  final ComicVineDatasource datasource;

  ComicVineRepositories({required this.datasource});

  @override
  Future<Comic> getComic(int id) {
    return datasource.getComic(id);
  }

  @override
  Future<List<Comic>> getPopularComics() {
    return datasource.getPopularComics();
  }

  @override
  Future<List<Comic>> searchComics(String query) {
    return datasource.searchComics(query);
  }
}
