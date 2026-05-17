class Comic {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final String volume;

  final List<String> characters;

  Comic({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.volume,
    required this.characters,
  });
}
