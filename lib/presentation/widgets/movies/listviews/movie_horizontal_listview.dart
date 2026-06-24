import 'package:flutter/material.dart';

import 'package:moviedb/domain/entities/movie.dart';

import '../cards/movie_card.dart';
import '../cards/movie_card_type.dart';

class MovieHorizontalListView extends StatelessWidget {
  final List<Movie> movies;

  final MovieCardType type;

  const MovieHorizontalListView({
    super.key,
    required this.movies,
    required this.type,
  });

  @override 
  Widget build(BuildContext context) {
    return SizedBox(
      height: type == MovieCardType.poster ? 320 : 220,

      child: ListView.builder(
        scrollDirection: Axis.horizontal,

        physics: const BouncingScrollPhysics(),

        itemCount: movies.length,

        itemBuilder: (_, index) {
          final movie = movies[index];

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: MovieCard(movie: movie, type: type),
          );
        },
      ),
    );
  }
}
