import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moviedb/domain/entities/movie.dart';
import 'package:moviedb/presentation/providers/actors/actors_by_movie_provider.dart';
import 'package:moviedb/presentation/providers/movies/movie_images_provider.dart';
import 'package:moviedb/presentation/providers/movies/movie_info_provider.dart';
import 'package:moviedb/presentation/providers/movies/movie_trailer_provider.dart';
import 'package:moviedb/presentation/providers/storage/favorites_movies_provider.dart';
import 'package:moviedb/presentation/widgets/movies/movie_metadata.dart';
import 'package:moviedb/presentation/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';
  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  final ScrollController _scrollController = ScrollController();

  double blur = 0;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(movieImagesProvider.notifier).imageOfMovies(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActos(widget.movieId);
    ref.read(movieTrailerProvider.notifier).loadTrailer(widget.movieId);

    _scrollController.addListener(() {
      final offset = _scrollController.offset;

      setState(() {
        blur = (offset / 20).clamp(0.0, 20);
        progress = (offset / 500).clamp(0.0, 1.0);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final movie = ref.watch(movieInfoProvider)[widget.movieId];
    final imageMovie = ref.watch(movieImagesProvider)[widget.movieId];
    final trailer = ref.watch(movieTrailerProvider)[widget.movieId];
    final favoritesMap = ref.watch(favoriteMoviesprovider);
    final isFavorite = favoritesMap.containsKey(movie?.id);

    if (movie == null) {
      return const Scaffold(
        body: SizedBox(height: 320, child: AspectRatio(aspectRatio: 16 / 9)),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: CachedNetworkImage(
                imageUrl: movie.backdropPath,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity((blur / 20) * 0.6),
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Opacity(
                opacity: progress,
                child: MovieLogoContent(
                  logoUrl: imageMovie != null && imageMovie.logos.isNotEmpty
                      ? imageMovie.logos.first
                      : null,
                  title: movie.title,
                  width: 0,
                  height: 120,
                  fontSize: 62,
                ),
              ),
            ),
          ),

          SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  actions: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Stack(
                        children: [
                          SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: MovieGradient.topRight,
                              ),
                            ),
                          ),
                          IconButton(
                          onPressed: () async {
                            //  Actualizar favoritos
                            ref
                                .read(favoriteMoviesprovider.notifier)
                                .toggleFavoriteMovie(movie);
                          },
                          //  CAMBIAR ESTO - Usar isFavorite directamente
                          icon: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: isFavorite ? Colors.red : Colors.white60,
                          ),
                        ),
                        ],
                      ),
                    ),
                  ],
                ),

                SliverToBoxAdapter(
                  child: Opacity(
                    opacity: (1 - progress),
                    child: SizedBox(
                      height: 600,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 12,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: MovieLogoContent(
                                logoUrl:
                                    imageMovie != null &&
                                        imageMovie.logos.isNotEmpty
                                    ? imageMovie.logos.first
                                    : null,
                                title: movie.title,
                                width: 300,
                                height: 120,
                                fontSize: 62,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          MovieMetadata(movie: movie),

                          const SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Opacity(
                    opacity: (1 - progress),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 140,
                          width: 140,
                          child: Stack(
                            children: [
                              // Círculo con fondo + gradiente
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.85),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black45,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 12,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                              ),

                              // Ícono centrado encima
                              Center(
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    if (trailer == null || trailer.key.isEmpty) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'No hay trailer disponible para esta película.',
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    final uri = Uri.parse(
                                      'https://www.youtube.com/watch?v=${trailer.key}',
                                    );

                                    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'No se pudo abrir el trailer.',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 140,
                                  ),
                                ),
                              ),

                              // Tap area
                            ],
                          ),
                        ),
                        SizedBox(height: 20),

                        SizedBox(
                          height: 40,
                          width: 40,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            iconSize: 40,
                            icon: const Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: const SizedBox(height: 80)),

                SliverToBoxAdapter(child: _MovieDetails(movie: movie)),

                SliverToBoxAdapter(child: const SizedBox(height: 80)),

                SliverToBoxAdapter(
                  child: _ActorsByMovie(movieId: movie.id.toString()),
                ),

                SliverToBoxAdapter(child: const SizedBox(height: 80)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(strokeWidth: 2);
    }

    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(8),
            width: 135,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(7),
                  child: Image.network(
                    actors[index].profilePath,
                    height: 180,
                    width: 135,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  actors[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(actors[index].character!, style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.4,
      padding: const EdgeInsets.all(16),
      child: Text(
        movie.overview,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

// class _CustomSliverAppbar extends StatelessWidget {
//   final Movie movie;
//   final MovieImages? imageMovie;

//   const _CustomSliverAppbar({required this.movie, required this.imageMovie});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return SliverAppBar(
//       backgroundColor: Colors.black,
//       expandedHeight: size.height * 0.6,
//       foregroundColor: Colors.white,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Stack(
//           children: [
//             SizedBox.expand(
//               child: CachedNetworkImage(
//                 imageUrl: movie.backdropPath,
//                 fit: BoxFit.cover,
//               ),
//             ),

//             Container(
//               decoration: BoxDecoration(gradient: MovieGradient.bottomCenter),
//             ),

//             Container(
//               decoration: BoxDecoration(gradient: MovieGradient.topLeft),
//             ),

//             Container(
//               decoration: BoxDecoration(gradient: MovieGradient.topRight),
//             ),

//             Padding(
//               padding: const EdgeInsets.only(top: 55, right: 15),
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: IconButton(
//                   onPressed: () {},
//                   icon: Icon(Icons.favorite_outline, color: Colors.white,),
//                 ),
//               ),
//             ),

//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Align(
//                 alignment: Alignment.bottomLeft,
//                 child: MovieLogoContent(
//                   logoUrl: imageMovie?.logos.isNotEmpty ?? false
//                       ? imageMovie!.logos.first
//                       : null,
//                   title: movie.title,
//                   width: 300,
//                   height: 180,
//                   fontSize: 60,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
