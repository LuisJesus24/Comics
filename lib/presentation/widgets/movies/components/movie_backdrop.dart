import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieBackdrop extends StatelessWidget {
  final String imageUrl;

  const MovieBackdrop({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        placeholder: (context, url) => Container(color: Colors.grey[850]),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[850],
          child: const Icon(Icons.broken_image, color: Colors.white38),
        ),
      ),
    );
  }
}
