class TrackSpotify {
  final String id;
  final String title;
  final String artist;
  final String imageUrl;
  final String? previewUrl;

  TrackSpotify({
    required this.id,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.previewUrl,
  });

  factory TrackSpotify.fromJson(Map<String, dynamic> json) {
    return TrackSpotify(
      id: json['id'] ?? '',

      title: json['name'] ?? '',

      artist: json['artists'].isNotEmpty
          ? json['artists'][0]['name']
          : 'Unknown Artist',

      imageUrl: json['album']['images'].isNotEmpty
          ? json['album']['images'][0]['url']
          : '',

      previewUrl: json['preview_url'] ?? '',
    );
  }
}
