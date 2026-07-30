import 'package:google_fonts/google_fonts.dart';
import 'package:moviedb/presentation/providers/storage/favorites_movies_provider.dart';
import 'package:moviedb/presentation/widgets/movies/movie_metadata.dart';
import 'package:moviedb/presentation/widgets/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:moviedb/presentation/widgets/widgets.dart';

class FavoritesViews extends ConsumerStatefulWidget {
  const FavoritesViews({super.key});

  @override
  ConsumerState<FavoritesViews> createState() => FavoritesViewsState();
}

class FavoritesViewsState extends ConsumerState<FavoritesViews> {
  @override
  void initState() {
    ref.read(favoriteMoviesprovider.notifier).loadNextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(favoriteMoviesprovider);
    final size = MediaQuery.of(context).size;
    final myMovieList = movies.values.toList();

    if (movies.isEmpty)
      return Scaffold(body: Center(child: Text('no hay peliculas favoritas')));

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Swiper(
            itemBuilder: (context, index) {
              final movie = myMovieList[index];

              return Stack(
                fit: StackFit.expand,
                children: [
                  MovieCard(movie: movie, type: MovieCardType.poster),
                  
                ],
              );
            },
            itemCount: myMovieList.length,
            itemHeight: size.height,
            itemWidth: 450.0,
            layout: SwiperLayout.STACK,
          ),
        ),
      ),
    );
  }
}
