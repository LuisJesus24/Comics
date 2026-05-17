import 'package:comics/domain/datasources/spotify_datasource.dart';
import 'package:comics/domain/entities/track.dart';
import 'package:comics/infrastructure/mappers/track_mappers.dart';
import 'package:comics/infrastructure/models/track_spotify.dart';
import 'package:dio/dio.dart';

class TrackSpotifyDatasource extends SpotifyDatasource {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.spotify.com/v1',
      headers: {
        'Authorization':
            'Bearer BQA-a3qwAyq40fptGX8odrSNr0I2BOO2fMzD7ByA4OKDhQrzrEBT0iKNtu9ENIBsG4sJVu8eAB4W-ley3i13BKig_mlwIsHklq_oZu0qW-x-radT0BxMc0dQQSdaBrczmHiMJnD0hdo',
      },
    ),
  );

  @override
  Future<List<Track>> searchTrack(String query) async {
    final response = await dio.get(
      '/search',
      queryParameters: {'q': query, 'type': 'track', 'limit': 10},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load popular comics');
    }

    final List items = response.data['tracks']['items'];

    final tracks = items
        .map((items) => TrackSpotify.fromJson(items))
        .map((items) => TrackMappers.trackSpotifyToEntity(items))
        .toList();

    return tracks;
  }

  @override
  Future<List<Track>> popularTracks() async {
    try {
      final response = await dio.get('/browse/featured-playlists');

      if (response.statusCode != 200) {
        throw Exception('Failed to load popular comics');
      }

      final List items = response.data['playlists']['items'];

      final tracks = items
          .map((items) => TrackSpotify.fromJson(items))
          .map((items) => TrackMappers.trackSpotifyToEntity(items))
          .toList();

      return tracks;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
