import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:comics/presentation/providers/movies/movies_providers.dart';
import 'package:comics/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _HomeView());
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadnextPage();
    ref.read(popularMoviesProvider.notifier).loadnextPage();
    ref.read(topRatedMoviesProvider.notifier).loadnextPage();
    ref.read(upcomingMoviesProvider.notifier).loadnextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: const CustomAppbar()),

        SliverToBoxAdapter(
          child: MoviesCarouselSlider(movies: nowPlayingMovies),
        ),

        SliverToBoxAdapter(
          child: MovieSection(
            title: 'Populars',

            movies: popularMovies,

            type: MovieCardType.poster,
          ),

          
        ),

        SliverToBoxAdapter(
          child: MovieSection(
            title: 'Top Rated',

            movies: topRatedMovies,

            type: MovieCardType.poster,
          ),
        ),

        SliverToBoxAdapter(
          child: MovieSection(
            title: 'Upcoming',

            movies: upcomingMovies,

            type: MovieCardType.backdrop,
          ),
        ),

        SliverToBoxAdapter(
          child: MovieSection(
            title: 'Now Playing',

            movies: nowPlayingMovies,

            type: MovieCardType.poster,
          ),
        ),

        // Expanded(
        //   child: ListView.builder(
        //     itemCount: nowPlayingMovies.length,
        //     itemBuilder: (context, index) {
        //       final movies = nowPlayingMovies[index];

        //       return ListTile(
        //         title: Text(movies.title),
        //       );
        //     },
        //   ),
        // )
      ],
    );
  }
}

