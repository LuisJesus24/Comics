
import 'package:comics/domain/entities/palette_data.dart';
import 'package:comics/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'package:comics/domain/entities/movie.dart';
import 'package:comics/domain/entities/movie_images.dart';

class MovieHeroBanner extends StatelessWidget {
  final Movie movie;
  final MovieImages images;
  final PaletteData palette; // 👈 Cambio aquí

  const MovieHeroBanner({
    super.key,
    required this.movie,
    required this.images,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    final backdrop = images.backdrops.isNotEmpty
        ? images.backdrops.first
        : movie.backdropPath;

    return SizedBox(
      height: 500,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(child: Text(palette.toString(),style: TextStyle(color: Colors.white),)),
          MovieBackdrop(imageUrl: backdrop),
          Positioned(
            child: ModernMovieGradient(palette: palette),
          ),
          // ... resto del contenido
        ],
      ),
    );
  }
}