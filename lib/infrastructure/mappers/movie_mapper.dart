import 'package:moviedb/domain/entities/movie.dart';
import 'package:moviedb/infrastructure/models/moviedb/movie_details.dart';
import 'package:moviedb/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDbToEntity(MovieMovieDb moviebd) => Movie(
    adult: moviebd.adult,
    backdropPath: (moviebd.backdropPath.isNotEmpty)
        ? 'https://image.tmdb.org/t/p/w500${moviebd.backdropPath}'
        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoWcWg0E8pSjBNi0TtiZsqu8uD2PAr_K11DA&s',
    genreIds: moviebd.genreIds.map((gen) => gen.toString()).toList(),
    id: moviebd.id,
    originalLanguage: moviebd.originalLanguage,
    originalTitle: moviebd.originalTitle,
    overview: moviebd.overview,
    popularity: moviebd.popularity,
    posterPath: (moviebd.posterPath.isNotEmpty)
        ? 'https://image.tmdb.org/t/p/w500${moviebd.posterPath}'
        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoWcWg0E8pSjBNi0TtiZsqu8uD2PAr_K11DA&s',
    releaseDate: moviebd.releaseDate,
    title: moviebd.title,
    video: moviebd.video,
    voteAverage: moviebd.voteAverage,
    voteCount: moviebd.voteCount, 
    runtime: moviebd.voteCount,
  );

  static Movie movieDetailsToEntity(MovieDetails moviebd) => Movie(
    adult: moviebd.adult,
    backdropPath: (moviebd.backdropPath != '')
        ? 'https://image.tmdb.org/t/p/w500${moviebd.backdropPath}'
        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoWcWg0E8pSjBNi0TtiZsqu8uD2PAr_K11DA&s',
    genreIds: moviebd.genres.map((gen) => gen.name).toList(),
    id: moviebd.id,
    originalLanguage: moviebd.originalLanguage,
    originalTitle: moviebd.originalTitle,
    overview: moviebd.overview,
    popularity: moviebd.popularity,
    posterPath: (moviebd.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500${moviebd.posterPath}'
        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoWcWg0E8pSjBNi0TtiZsqu8uD2PAr_K11DA&s',
    releaseDate: moviebd.releaseDate,
    title: moviebd.title,
    video: moviebd.video,
    voteAverage: moviebd.voteAverage,
    voteCount: moviebd.voteCount, 
    runtime: moviebd.runtime,
  );
}
