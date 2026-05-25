import 'package:comics/domain/entities/movie.dart';
import 'package:comics/domain/entities/palette_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class MovieScreen extends ConsumerWidget {
  final Movie movie;

  const MovieScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesAsync = ref.watch(movieImagesProvider(movie.id));
    final paletteAsync = ref.watch(moviePaletteProvider(movie.posterPath));

    return paletteAsync.when(
      data: (palette) => _buildScaffold(context, imagesAsync, palette),
      loading: () => _buildScaffold(context, imagesAsync, PaletteData()),
      error: (_, __) => _buildScaffold(context, imagesAsync, PaletteData()),
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    AsyncValue imagesAsync,
    PaletteData palette,
  ) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Transparent para que se vea el gradient
      body: PaletteBackground(
        palette: palette,
        child: imagesAsync.when(
          data: (images) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: MovieHeroBanner(
                    movie: movie,
                    images: images,
                    palette: palette,
                  ),
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('$error')),
        ),
      ),
    );
  }
}