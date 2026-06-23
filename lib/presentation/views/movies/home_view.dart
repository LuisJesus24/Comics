import 'package:moviedb/presentation/providers/providers.dart';
import 'package:moviedb/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
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

    final isLoading = 
    nowPlayingMovies.isEmpty ||
    popularMovies.isEmpty ||
    topRatedMovies.isEmpty ||
    upcomingMovies.isEmpty;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: const CustomAppbar()),
        SliverToBoxAdapter(
          child: isLoading
              ? const CarouselSkeleton()
              : MoviesCarouselSlider(movies: nowPlayingMovies),
        ),
        SliverToBoxAdapter(
          child: isLoading
              ? const PosterSectionSkeleton()
              : MovieSection(
                  title: 'Populars',
                  movies: popularMovies,
                  type: MovieCardType.poster,
                ),
        ),
        SliverToBoxAdapter(
          child: isLoading
              ? const PosterSectionSkeleton()
              : MovieSection(
                  title: 'Top Rated',
                  movies: topRatedMovies,
                  type: MovieCardType.poster,
                ),
        ),
        SliverToBoxAdapter(
          child: isLoading
              ? const BackdropSectionSkeleton()
              : MovieSection(
                  title: 'Upcoming',
                  movies: upcomingMovies,
                  type: MovieCardType.backdrop,
                ),
        ),
        SliverToBoxAdapter(
          child: isLoading
              ? const PosterSectionSkeleton()
              : MovieSection(
                  title: 'Now Playing',
                  movies: nowPlayingMovies,
                  type: MovieCardType.poster,
                ),
        ),
      ],
    );
  }
}
