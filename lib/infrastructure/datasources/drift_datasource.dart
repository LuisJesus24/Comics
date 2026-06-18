import 'package:comics/config/database/database.dart';
import 'package:comics/domain/datasources/local_storage_datasource.dart';
import 'package:comics/domain/entities/movie.dart';

class DriftDatasource extends LocalStorageDatasource {
  final AppDatabase database;

  DriftDatasource([AppDatabase? databaseToUse])
    : database = databaseToUse ?? db;

  @override
  Future<bool> isFavoriteMovie(int movieId) async {
    //construir el query

    final query = database.select(database.favoriteMovies)
      ..where((table) => table.movieId.equals(movieId));

    //Ejecutar el query

    final favoriteMovie = await query.getSingleOrNull();

    //Retornar el resultado

    return favoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadFavoriteMovies({
    int limit = 10,
    int offset = 0,
  }) async {
    //construir el query

    final query = database.select(database.favoriteMovies)
      ..limit(limit, offset: offset);

    //Ejecutar el query

    final favoriteMoviesRows = await query.get();

    //Transformar las peliculas

    final movies = favoriteMoviesRows
        .map(
          (row) => Movie(
            adult: false,
            backdropPath: row.backdropPath,
            genreIds: const [],
            id: row.movieId,
            originalLanguage: '',
            originalTitle: row.originalTitle,
            overview: '',
            popularity: 0,
            posterPath: row.posterPath,
            releaseDate: DateTime.now(),
            title: row.title,
            video: false,
            voteAverage: 0,
            voteCount: 0,
            runtime: 0,
          ),
        )
        .toList();

    //Retornar el resultado

    return movies;
  }

  @override
  Future<void> toggleFavoriteMovie(Movie movie) async {
    final isFavorite = await isFavoriteMovie(movie.id);

    if (isFavorite) {
      final deleteQuery = database.delete(database.favoriteMovies)
        ..where((table) => table.movieId.equals(movie.id));

      await deleteQuery.go();
      return;
    }

    await database
        .into(database.favoriteMovies)
        .insert(
          FavoriteMoviesCompanion.insert(
            movieId: movie.id,
            backdropPath: movie.backdropPath,
            originalTitle: movie.originalTitle,
            posterPath: movie.posterPath,
            title: movie.title,
          ),
        );
  }
}
