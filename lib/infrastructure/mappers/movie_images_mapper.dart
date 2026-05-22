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
                '$imageBaseUrl${backdrop.filePath}',
          )
          .toList(),

      posters: response.posters
          .where((poster) => poster.filePath.isNotEmpty)
          .map(
            (poster) =>
                '$imageBaseUrl${poster.filePath}',
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