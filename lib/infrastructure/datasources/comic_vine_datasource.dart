import 'package:comics/config/constants/environment.dart';
import 'package:comics/domain/datasources/comics_datasource.dart';
import 'package:comics/domain/entities/comic.dart';
import 'package:comics/infrastructure/mappers/comic_mappers.dart';
import 'package:comics/infrastructure/models/comic_comicvine.dart';
import 'package:dio/dio.dart';

class ComicVineDatasource extends ComicsDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://comicvine.gamespot.com/api/',
      queryParameters: {'api_key': Environment.comicVineKey, 'format': 'json'},
    ),
  );

  @override
  Future<Comic> getComic(int id) async {
    final response = await dio.get('issue/4000-$id/');

    if (response.statusCode != 200) {
      throw Exception('Failed to load comic');
    }

    final comicData = response.data['results'];

    final ComicVine comicVine = ComicVine.fromJson(comicData);

    final comic = ComicMappers.comicVineToEntity(comicVine);

    return comic;
  }

  @override
  Future<List<Comic>> getPopularComics() async {
    final response = await dio.get(
      'issues/',
      queryParameters: {'sort': 'store_date:desc', 'limit': 50},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load popular comics');
    }

    final List comicsData = response.data['results'];

    final comics = comicsData
        .map((comicData) => ComicVine.fromJson(comicData))
        .map((comicVine) => ComicMappers.comicVineToEntity(comicVine))
        .toList();

    return comics;
  }

  @override
  Future<List<Comic>> searchComics(String query) async {
    final response = await dio.get(
      'search/',
      queryParameters: {'query': query, 'resources': 'issue', 'limit': 20},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to search comics');
    }

    final List comicsData = response.data['results'];

    final comics = comicsData
        .map((comicsData) => ComicVine.fromJson(comicsData))
        .map((comicsData) => ComicMappers.comicVineToEntity(comicsData))
        .toList();

    return comics;
  }
}
