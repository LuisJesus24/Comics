class ComicVine {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final String volume;

  final List<String> characters;

  ComicVine({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.volume,
    required this.characters,
  });

  factory ComicVine.fromJson(Map<String, dynamic> json) {
    return ComicVine(
      id: json['id'] ?? 0,
      name: json['volume']?['name'] ?? 'No Title',
      imageUrl: json['image']?['original_url'] ?? '',
      description: json['description'] ?? '',
      volume: json['volume']?['name'] ?? '',
      characters:
          (json['characters_credits'] as List?)
              ?.map((character) => character['name'] as String)
              .toList() ??
          [],
    );
  }
}
