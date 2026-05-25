import 'package:comics/presentation/widgets/movies/components/movie_card_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:comics/domain/entities/movie.dart';

import 'package:comics/presentation/providers/providers.dart';
import 'package:comics/presentation/screens/screens.dart';

import '../components/movie_backdrop.dart';
import '../components/movie_gradient.dart';

import 'movie_card_type.dart';

class MovieCard extends ConsumerWidget {
  final Movie movie;
  final MovieCardType type;

  const MovieCard({super.key, required this.movie, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPoster = type == MovieCardType.poster;

    final imageUrl = isPoster ? movie.posterPath : movie.backdropPath;

    final imagesAsync = ref.watch(movieImagesProvider(movie.id));

    final logoUrl = imagesAsync.when(
      data: (images) {
        if (images.logos.isEmpty) {
          return null;
        }

        return images.logos.first;
      },

      loading: () => null,

      error: (_, __) => null,
    );

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MovieScreen(movie: movie)),
        );
      },

      child: AspectRatio(
        aspectRatio: isPoster ? 2 / 3 : 16 / 9,

        child: Container(
          margin: const EdgeInsets.all(12),

          child: Stack(
            fit: StackFit.expand,

            children: [
              MovieBackdrop(imageUrl: imageUrl),

              const MovieGradient(),

              if (!isPoster) MovieCardInfo(movie: movie, logoUrl: logoUrl),
            ],
          ),
        ),
      ),
    );
  }
}
