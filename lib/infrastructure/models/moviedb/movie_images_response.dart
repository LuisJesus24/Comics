import 'image_model.dart';

class MovieImagesResponse {

  final List<ImageModel> backdrops;
  final List<ImageModel> posters;
  final List<ImageModel> logos;

  MovieImagesResponse({
    required this.backdrops,
    required this.posters,
    required this.logos,
  });

  factory MovieImagesResponse.fromJson(
    Map<String, dynamic> json,
  ) {

    return MovieImagesResponse(

      backdrops: (json['backdrops'] as List)
          .map(
            (e) => ImageModel.fromJson(e),
          )
          .toList(),

      posters: (json['posters'] as List)
          .map(
            (e) => ImageModel.fromJson(e),
          )
          .toList(),

      logos: (json['logos'] as List)
          .map(
            (e) => ImageModel.fromJson(e),
          )
          .toList(),
    );
  }
}