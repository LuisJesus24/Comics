import 'package:comics/domain/entities/track.dart';
import 'package:comics/domain/repositories/spotify_repository.dart';
import 'package:comics/infrastructure/datasources/track_spotify_datasource.dart';

class TrackSpotifyRepositories extends SpotifyRepository {
  final TrackSpotifyDatasource trackDatasource;

  TrackSpotifyRepositories({required this.trackDatasource});

  @override
  Future<List<Track>> searchTrack(String query) {
    return trackDatasource.searchTrack(query);
  }

  @override
  Future<List<Track>> popularTracks() {
    return trackDatasource.popularTracks();
  }
}
