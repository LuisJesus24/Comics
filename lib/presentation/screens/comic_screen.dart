import 'package:comics/presentation/providers/comics/comic_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComicScreen extends ConsumerWidget {
  static const name = "comic-screen";

  final int comicId;

  const ComicScreen({super.key, required this.comicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comicAsync = ref.watch(comicProvider(comicId));

    return Scaffold(
      body: comicAsync.when(
        data: (comic) {
          return SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 500,

                  pinned: true,

                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,

                      children: [
                        Hero(
                          tag: comic.id,

                          child: Image.network(
                            comic.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Colors.black],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          comic.name,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 20),

                        Text(comic.volume, style: TextStyle(fontSize: 18)),

                        SizedBox(height: 30),

                        Html(data: comic.description),

                        const SizedBox(height: 40),

                        const Text(
                          'Characters',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // CharactersComics(characters: comic.characters),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) => Text('error: $error'),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
