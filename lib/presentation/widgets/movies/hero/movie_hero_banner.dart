import 'package:animate_do/animate_do.dart';
import 'package:comics/presentation/widgets/movies/hero/movie_logo.dart';
import 'package:flutter/material.dart';

import 'package:comics/domain/entities/movie.dart';
import 'package:comics/domain/entities/movie_images.dart';

import '../components/movie_backdrop.dart';
import '../components/movie_gradient.dart';

class MovieHeroBanner extends StatelessWidget {
  final Movie movie;
  final MovieImages images;

  const MovieHeroBanner({super.key, required this.movie, required this.images});

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
          MovieBackdrop(imageUrl: backdrop),

          const MovieGradient(),

          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(24),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  FadeIn(
                    child: MovieLogo(images: images, movie: movie),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    movie.overview,

                    maxLines: 4,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
