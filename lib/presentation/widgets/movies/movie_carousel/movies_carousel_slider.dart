import 'package:moviedb/presentation/widgets/movies/cards/movie_card.dart';
import 'package:moviedb/presentation/widgets/movies/cards/movie_card_type.dart';
import 'package:moviedb/presentation/widgets/movies/listviews/movie_horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/domain/entities/movie.dart';
import 'package:moviedb/presentation/widgets/movies/movie_carousel/movie_carousel_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MoviesCarouselSlider extends StatefulWidget {
  final List<Movie> movies;

  const MoviesCarouselSlider({super.key, required this.movies});

  @override
  State<MoviesCarouselSlider> createState() => _MoviesCarouselSliderState();
}

class _MoviesCarouselSliderState extends State<MoviesCarouselSlider> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.movies.length < 2) {
      return const SizedBox.shrink();
    }

    final CarouselSliderController carouselController =
        CarouselSliderController();

    final screenHeight = MediaQuery.of(context).size.height;

    final useScrolling = widget.movies.length > 5;

    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.6,

          child: CarouselSlider.builder(
            carouselController: carouselController,

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
        ),

        SizedBox(height: 10),

        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 120,
            height: 20,

            child: Center(
              child: AnimatedSmoothIndicator(
                
                activeIndex: currentIndex,
                count: widget.movies.length,
              
                effect: useScrolling
                    ? ScrollingDotsEffect(
                        maxVisibleDots: 5,
              
                        dotHeight: 8,
                        dotWidth: 8,
              
                        activeDotColor: colors.primary,
                        dotColor: colors.secondary,
                      )
                    : WormEffect(
                        dotHeight: 8,
                        dotWidth: 8,
              
                        spacing: 8,
              
                        radius: 20,
              
                        activeDotColor: colors.primary,
                        dotColor: colors.secondary,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
