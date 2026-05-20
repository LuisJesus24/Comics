import 'package:comics/domain/entities/movie.dart';
import 'package:comics/presentation/widgets/movies/movie_carousel_image.dart';
import 'package:flutter/material.dart';

class MovieCarouselItem extends StatelessWidget {

  final Movie movie;
  final bool isMain;

  const MovieCarouselItem({
    super.key,
    required this.movie,
    required this.isMain,
  });

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),

      margin: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),

        border: Border.all(
          color: isMain
              ? Colors.white70
              : Colors.transparent,

          width: 4,
        ),
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),

        child: MovieCarouselImage(
          imageUrl: movie.posterPath,
        ),
      ),
    );
  }
}