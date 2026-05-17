import 'package:comics/domain/entities/track.dart';

abstract class SpotifyDatasource {
  Future<List<Track>> searchTrack(String query);

  Future<List<Track>> popularTracks();
}
