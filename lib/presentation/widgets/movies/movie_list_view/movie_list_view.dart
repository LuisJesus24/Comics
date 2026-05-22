
import 'package:comics/domain/entities/movie.dart';
import 'package:comics/presentation/screens/movies/home_screen.dart';
import 'package:comics/presentation/widgets/movies/movie_list_view/movie_list_view_card.dart';
import 'package:flutter/material.dart';

class MovieListView extends StatelessWidget {
  final List<Movie> movies;
  
  final MovieCardType type;

  const MovieListView({super.key, required this.movies, required this.type});

  @override
  Widget build(BuildContext context) {


    return SizedBox(

      height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
        
            return MovieListViewCard(
              movie: movie,
              type: type,
            );
          },
        ),
      
    );
  }
}
