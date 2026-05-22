import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comics/domain/entities/movie.dart';
import 'package:comics/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../screens/screens.dart';

class MovieListViewCard extends ConsumerWidget {
  final Movie movie;
  final MovieCardType type;

  const MovieListViewCard({super.key, required this.movie, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(movieImagesProvider(movie.id));

    final isPoster = type == MovieCardType.poster;

    final imageUrl = isPoster ? movie.posterPath : movie.backdropPath;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MovieScreen(movie: movie)),
        );
      },

      child: AspectRatio(
        aspectRatio: isPoster ? 2 / 3 : 16 / 9,

        child: Container(
          margin: const EdgeInsets.all(12),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),

            // border: Border.all(color: Colors.white60, width: 4),
          ),

          child: Container(
            
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25)
            ),

            child: Stack(
              children: [
                Positioned(

                  right: 0,
                  top:0,
                  bottom: 0,

                  child: ClipRRect(

                    borderRadius: BorderRadiusGeometry.circular(20),

                    child: CachedNetworkImage(

                      imageUrl: movie.backdropPath,

                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                //GRADIENT
                Container(
                  decoration: const BoxDecoration(

                    borderRadius: BorderRadius.all(Radius.circular(20)),

                    gradient: LinearGradient(

                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,

                      colors: [
                        Colors.black,
                        Colors.transparent
                      ]
                    )
                  ),
                ),



                //INFO
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 230, bottom: 10),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        images.when(
                          data: (image) {
                            if (image.logos.isEmpty) return const SizedBox();

                            return FadeInDown(
                              child: CachedNetworkImage(
                              
                                imageUrl: image.logos.first,
                              
                              
                              ),
                            );
                          },
                          error: (error, stackTrace) => Text('$error'),
                          loading: () => SizedBox(),
                        ),

                        
                      ],
                    ),
                  ),
                ),
                

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
