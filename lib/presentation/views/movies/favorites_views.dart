import 'package:comics/presentation/providers/storage/favorites_movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

    final myMovieList = movies.values.toList();

    if (movies.isEmpty)
      return Scaffold(body: Center(child: Text('no hay peliculas favoritas')));

    return Scaffold(
      body: ListView.builder(
        itemCount: myMovieList.length,
        itemBuilder: (context, index) {
          final movie = myMovieList[index];
          return ListTile(
            title: Text(movie.title),
            leading: Image.network(movie.posterPath, height: 300,),
          );
        },
      ),
    );
  }
}
