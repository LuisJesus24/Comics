import 'package:flutter/material.dart';
import 'package:comics/domain/entities/movie.dart';
import 'package:comics/presentation/widgets/movies/movie_carousel_item.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MoviesCarouselSlider extends StatefulWidget {
  final List<Movie> movies;

  const MoviesCarouselSlider({
    super.key,
    required this.movies,
  });

  @override
  State<MoviesCarouselSlider> createState() =>
      _MoviesCarouselSliderState();
}

class _MoviesCarouselSliderState
    extends State<MoviesCarouselSlider> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final screenHeight =
        MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight * 0.6,

      child: CarouselSlider.builder(
        itemCount: widget.movies.length,

        itemBuilder: (context, index, realIndex) {

          final movie = widget.movies[index];

          return MovieCarouselItem(
            movie: movie,
            isMain: index == currentIndex,
          );
        },

        options: CarouselOptions(
          height: screenHeight * 0.6,
          autoPlay: true,
          viewportFraction: 0.8,
          enlargeCenterPage: true,
          enlargeFactor: 0.17,

          onPageChanged: (index, reason) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}