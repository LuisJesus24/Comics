class FavoriteComic {
  final int id;
  final String name;
  final String imageUrl;
  final DateTime addedAt;

  FavoriteComic({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.addedAt,
  });


  factory FavoriteComic.fromMap(Map<String, dynamic> map) {
    return FavoriteComic(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      addedAt: DateTime.parse(map['addedAt'] ?? DateTime.now().toIso8601String()),
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'addedAt': addedAt.toIso8601String(),
    };
  }
}
