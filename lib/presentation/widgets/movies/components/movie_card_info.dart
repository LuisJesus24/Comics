import 'package:flutter/material.dart';

import 'package:comics/domain/entities/movie.dart';

import '../cards/movie_card_logo.dart';

class MovieCardInfo extends StatelessWidget {
  final Movie movie;
  final String? logoUrl;

  const MovieCardInfo({super.key, required this.movie, this.logoUrl});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [MovieCardLogo(logoUrl: logoUrl, title: movie.title)],
        ),
      ),
    ); 
  }
}
