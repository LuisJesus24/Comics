import 'package:flutter/material.dart';

import 'package:comics/domain/entities/movie.dart';
import 'package:comics/domain/entities/movie_images.dart';

import '../components/movie_logo_content.dart';

class MovieLogo extends StatelessWidget {
  final Movie movie;
  final MovieImages images;

  const MovieLogo({super.key, required this.movie, required this.images});

  @override
  Widget build(BuildContext context) {
    final logoUrl = images.logos.isNotEmpty ? images.logos.first : null;

    return MovieLogoContent(
      logoUrl: logoUrl,

      title: movie.title,

      width: 250,

      height: 120,

      fontSize: 42,
    );
  }
}
