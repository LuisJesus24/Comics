import 'package:comics/presentation/widgets/movies/components/movie_logo_content.dart';
import 'package:flutter/material.dart';

class MovieCardLogo extends StatelessWidget {
  final String? logoUrl;
  final String title;

  const MovieCardLogo({super.key, required this.logoUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: MovieLogoContent(
        logoUrl: logoUrl,
      
        title: title,
      
        width: 180,
      
        height: 80,
      
        fontSize: 24,
      ),
    );
  } 
}
