import 'package:comics/infrastructure/models/moviedb/movie_images_response.dart';

import '../../domain/entities/movie_images.dart';

class MovieImagesMapper {

  static const imageBaseUrl =
      'https://image.tmdb.org/t/p/w780';

  static MovieImages toEntity(
    MovieImagesResponse response,
  ) {

    return MovieImages(

      backdrops: response.backdrops
          .where((backdrop) => backdrop.filePath.isNotEmpty)
          .map(
            (backdrop) =>
                '$imageBaseUrl${backdrop.filePath}' != '' ? '$imageBaseUrl${backdrop.filePath}' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoWcWg0E8pSjBNi0TtiZsqu8uD2PAr_K11DA&s',
          )
          .toList(),

      posters: response.posters
          .where((poster) => poster.filePath.isNotEmpty)
          .map(
            (poster) =>
                '$imageBaseUrl${poster.filePath}' != '' ? '$imageBaseUrl${poster.filePath}' : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoWcWg0E8pSjBNi0TtiZsqu8uD2PAr_K11DA&s',
          )
          .toList(),

      logos: response.logos
          .where((logo) => ( logo.filePath.isNotEmpty && logo.langugeCode == 'en'))
          .map(
            (logo) =>
                '$imageBaseUrl${logo.filePath}',
          )
          .toList(),
    );
  }
}