import 'package:comics/domain/entities/comic.dart';
import 'package:comics/infrastructure/models/comic_comicvine.dart';

class ComicMappers {
  static Comic comicVineToEntity(ComicVine comicVine) {
    return Comic(
      id: comicVine.id,
      name: comicVine.name,
      imageUrl: comicVine.imageUrl,
      description: comicVine.description,
      volume: comicVine.volume,
      characters: comicVine.characters,
    );
  }
}
