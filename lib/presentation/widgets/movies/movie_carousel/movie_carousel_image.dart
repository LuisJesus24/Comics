import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieCarouselImage extends StatelessWidget {
  final String imageUrl;

  const MovieCarouselImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      width: double.infinity,

      placeholder: (context, url) =>
      const Center(
        child: CircularProgressIndicator(),
      ),

      errorWidget: (context, url, error) =>
          const Icon(Icons.error),
    );
  }
}
