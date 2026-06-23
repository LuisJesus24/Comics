import 'package:comics/presentation/widgets/movies/components/movie_card_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:comics/domain/entities/movie.dart';

import 'package:comics/presentation/providers/providers.dart';
import 'package:go_router/go_router.dart';

import '../components/movie_backdrop.dart';
import '../components/movie_gradient.dart';

import 'movie_card_type.dart';

class MovieCard extends ConsumerStatefulWidget {
  final Movie movie;
  final MovieCardType type;

  const MovieCard({super.key, required this.movie, required this.type});

  @override
  MovieCardState createState() => MovieCardState();
}

class MovieCardState extends ConsumerState<MovieCard> {
  @override
  void initState() {
    super.initState();

    ref
        .read(movieImagesProvider.notifier)
        .imageOfMovies(widget.movie.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final isPoster = widget.type == MovieCardType.poster;

    final imageUrl = isPoster
        ? widget.movie.posterPath
        : widget.movie.backdropPath;

    final imagesAsync = ref.watch(
      movieImagesProvider,
    )[widget.movie.id.toString()];

    

    return GestureDetector(
      onTap: () {
        context.push('/home/0/movie/${widget.movie.id}');
      },

      child: AspectRatio(
        aspectRatio: isPoster ? 2 / 3 : 16 / 9,

        child: Container(
          margin: const EdgeInsets.all(12),

          child: Stack(
            fit: StackFit.expand,

            children: [
              MovieBackdrop(imageUrl: imageUrl),

              if (!isPoster)
                Container(
                  decoration: BoxDecoration(
                    gradient: MovieGradient.bottomCenter,
                  ),
                ),


              if(!isPoster && imagesAsync != null) MovieCardInfo(
                  movie: widget.movie,
                  logoUrl: imagesAsync .logos.isNotEmpty
                      ? imagesAsync.logos.first
                      : '',
                ),
            ],
          ),
        ),
      ),
    );
  }
}

