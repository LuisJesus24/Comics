import 'package:comics/presentation/widgets/movies/listviews/movie_horizontal_listview.dart';
import 'package:flutter/material.dart';

import 'package:comics/domain/entities/movie.dart';

import '../cards/movie_card_type.dart';

class MovieSection extends StatelessWidget {
  final String title;

  final List<Movie> movies;

  final MovieCardType type;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),

          child: Text(
            title,

            style: TextStyle(
              color: Colors.white,

              fontSize: 24,

              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 10),

        MovieHorizontalListView(movies: movies, type: type),
      ],
    );
  }
}
