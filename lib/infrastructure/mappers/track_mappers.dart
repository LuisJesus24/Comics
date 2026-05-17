import 'package:comics/domain/entities/track.dart';
import 'package:comics/infrastructure/models/track_spotify.dart';

class TrackMappers {
  static Track trackSpotifyToEntity(TrackSpotify trackSpotify) {
    return Track(
      id: trackSpotify.id,
      title: trackSpotify.title,
      artist: trackSpotify.artist,
      imageUrl: trackSpotify.imageUrl,
    );
  }
}
