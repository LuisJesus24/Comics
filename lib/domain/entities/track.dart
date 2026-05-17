class Track {
  final String id;
  final String title;
  final String artist;
  final String imageUrl;
  final String? previewUrl;

  Track({
    required this.id,
    required this.title,
    required this.artist,
    required this.imageUrl,
    this.previewUrl,
  });
}
