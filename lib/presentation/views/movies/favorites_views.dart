import 'package:moviedb/presentation/providers/storage/favorites_movies_provider.dart';
import 'package:moviedb/presentation/widgets/shared/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

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
      
      body: SizedBox.expand(
        child: Center(
          child: Swiper(
            itemBuilder: (context, index) {
              final movie = myMovieList[index];
          
              return Container(
                margin: EdgeInsets.only(right: 0),
                height: size.height,
                child: ClipRRect(
                  child: Image.network(
                    movie.posterPath,
                    
                  ),
                ),
              );
            },
            itemCount: myMovieList.length,
            itemWidth: 370.0,
            layout: SwiperLayout.STACK,
          ),
        ),
      ),
    );
  }
}
