import 'package:moviedb/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MovieMetadata extends StatelessWidget {
  final Movie movie;

  const MovieMetadata({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          Text(
            '${movie.releaseDate.year.toInt()} • ${movie.genreIds[0]} • ${movie.runtime} m',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),

          const SizedBox(height: 15),

          _Rating(movie: movie,),
        ],
      ),
    );
  }
}

class _Rating extends StatelessWidget {
  
  final Movie movie;

  const _Rating({required this.movie});

  @override
  Widget build(BuildContext context) {
    return 
        RatingBarIndicator(
          rating: movie.voteAverage / 2,
          itemCount: 5,
          itemSize: 18,
          itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
        );

        
      
    
  }
}
