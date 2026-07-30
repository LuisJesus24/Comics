class MovieVideo {
  final String name;
  final String key;
  final String site;
  final String type;

  MovieVideo({
    required this.name,
    required this.key,
    required this.site,
    required this.type,
  });

  factory MovieVideo.fromJson(Map<String, dynamic> json) {
    return MovieVideo(
      name: json['name'] ?? '',
      key: json['key'] ?? '',
      site: json['site'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
