
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:comics/presentation/widgets/widgets.dart';
import 'package:comics/presentation/providers/movies/movies_providers.dart';



class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

enum MovieCardType { poster, backdrop }

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadnextPage();
  }
  

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    

    return CustomScrollView(
      slivers: [

        SliverToBoxAdapter(
          child: const CustomAppbar(),
        ),

        SliverToBoxAdapter(
          child: MoviesCarouselSlider(movies: nowPlayingMovies),
        ),


        SliverToBoxAdapter(
          child: MovieListView(movies: nowPlayingMovies, type: MovieCardType.backdrop,)
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
