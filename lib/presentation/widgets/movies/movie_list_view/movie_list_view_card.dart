import 'package:cached_network_image/cached_network_image.dart';
import 'package:comics/presentation/screens/movies/home_screen.dart';
import 'package:flutter/material.dart';



class MovieListViewCard extends StatelessWidget {
  final String imageUrl;
  final MovieCardType type;

  const MovieListViewCard({super.key, required this.imageUrl, required this.type});

  @override
  Widget build(BuildContext context) {
    final isPoster = type == MovieCardType.poster;

    return AspectRatio(
      aspectRatio: isPoster
        ? 2 / 3
        : 16 / 9,
      
      child: Container(
        
        margin: EdgeInsets.all(12),

        

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(25),

          border: Border.all(
            color: Colors.white60,

            width: 4
          ),
          
        ),

        
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(20),

        
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,

            placeholder: (context, url) =>
            const Center(
              child: CircularProgressIndicator(),
            ),

            errorWidget: (context, url, error) =>
                const Icon(Icons.error),
          )
        ),
      ),
    );
  }
}
