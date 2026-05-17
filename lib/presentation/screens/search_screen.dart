import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:comics/presentation/providers/comics/comic_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  ConsumerState<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;

  void _onSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(Duration(milliseconds: 500), () {
      ref.read(searchQueryProvider.notifier).state = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final resultsAsync = ref.watch(searchComicsProvider(query));

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Buscar comics o personajes',
            border: InputBorder.none,
          ),
          onChanged: _onSearch,
        ),
      ),

      body: resultsAsync.when(
        data: (comics) => MasonryGridView.builder(
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),

          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          itemCount: comics.length,
          itemBuilder: (context, index) {
            final comic = comics[index];
            final heights = [200.0, 250.0, 180.0, 300.0, 220.0];
            final height = heights[index % heights.length];

            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                comic.imageUrl,
                fit: BoxFit.cover,
                height: height,
                width: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Container(
                      width: double.infinity,
                      height: height,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: () => context.push('/comics/${comic.id}'),
                    child: FadeIn(child: child),
                  );
                },
              ),
            );
          },
        ),
        error: (_, __) => const Center(
          child: Text('Error', style: TextStyle(color: Colors.white)),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
