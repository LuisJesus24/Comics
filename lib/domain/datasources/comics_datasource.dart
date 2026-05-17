import 'package:comics/domain/entities/comic.dart';

abstract class ComicsDatasource {
  Future<Comic> getComic(int id);

  Future<List<Comic>> getPopularComics();

  Future<List<Comic>> searchComics(String query);
}
