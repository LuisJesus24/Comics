import 'package:comics/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class MovieScreen extends ConsumerWidget {

  final Movie movie;

  const MovieScreen({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final imagesAsync = ref.watch(
      movieImagesProvider(movie.id),
    );

    return Scaffold(
      body: imagesAsync.when(

        data: (images) {

          return ListView(
            children: [

              SizedBox(
                height: 500,
                child: Stack(
                  fit: StackFit.expand,
                  children: [

                    Image.network(
                      images.backdrops[0],
                      fit: BoxFit.cover,
                    ),

                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black87,
                          ],
                        ),
                      ),
                    ),

                    if (images.logos.isNotEmpty)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Image.network(
                            images.logos.first,
                            height: 100,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.backdrops.length,
                  itemBuilder: (_, index) {

                    final image = images.backdrops[index];

                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(image),
                          ),
                        ),

                        Text('$index')
                      ]
                    );
                  },
                ),
              ),

              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.posters.length,
                  itemBuilder: (_, index) {

                    final image = images.posters[index];

                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(image),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.logos.length,
                  itemBuilder: (_, index) {

                    final image = images.logos[index];

                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(image),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },

        loading: () =>
            const Center(child: CircularProgressIndicator()),

        error: (_, __) =>
            const Center(child: Text('Error')),
      ),
    );
  }
}