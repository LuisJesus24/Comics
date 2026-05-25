import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:comics/domain/entities/movie.dart';

import 'package:comics/presentation/providers/providers.dart';

import 'package:comics/presentation/widgets/movies/hero/movie_hero_banner.dart';

class MovieScreen extends ConsumerWidget {
  final Movie movie;

  const MovieScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesAsync = ref.watch(movieImagesProvider(movie.id));

    return Scaffold(
      backgroundColor: Colors.black,

      body: imagesAsync.when(
        data: (images) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: MovieHeroBanner(movie: movie, images: images),
              ),
            ],
          );
        },

        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stackTrace) => Center(child: Text('$error')),
      ),
    );
  }
}
