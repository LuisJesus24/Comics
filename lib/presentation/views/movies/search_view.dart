import 'package:moviedb/presentation/providers/movies/movies_providers.dart';
import 'package:moviedb/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<SearchView> createState() => SearchViewState();
}

class SearchViewState extends ConsumerState<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    ref.read(searchMoviesProvider.notifier).search(query);
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchMoviesProvider);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return CustomScrollView(
      slivers: [
        // Search AppBar
        SliverAppBar(
          floating: true,
          pinned: true,
          backgroundColor: colors.surface,
          elevation: 0,
          title: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: TextField(
                controller: _searchController,
                focusNode: _focusNode,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Buscar películas...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            ref.read(searchMoviesProvider.notifier).reset();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),
        ),
        // Search Results or Empty State
        if (_searchController.text.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    size: 64,
                    color: colors.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Busca tus películas favoritas',
                    style: textTheme.titleMedium?.copyWith(
                      color: colors.outline,
                    ),
                  ),
                ],
              ),
            ),
          )
        else if (searchResults.isEmpty)
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.movie_outlined,
                    size: 64,
                    color: colors.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No se encontraron películas',
                    style: textTheme.titleMedium?.copyWith(
                      color: colors.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Intenta con otra búsqueda',
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.outlineVariant,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.all(4),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 4,
                crossAxisSpacing: 2,
                childAspectRatio: 0.65,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => MovieCard(
                  movie: searchResults[index],
                  type: MovieCardType.poster,
                ),
                childCount: searchResults.length,
              ),
            ),
          ),
      ],
    );
  }
}
