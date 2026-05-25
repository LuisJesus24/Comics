// lib/presentation/widgets/movies/components/modern_movie_gradient.dart
import 'package:flutter/material.dart';
import 'package:comics/domain/entities/palette_data.dart';

class ModernMovieGradient extends StatelessWidget {
  final PaletteData palette;
  final bool animate;

  const ModernMovieGradient({
    super.key,
    required this.palette,
    this.animate = false,
  });

  @override
  Widget build(BuildContext context) {
    // Obtener colores con fallbacks seguros
    final primaryColor = palette.primaryForUI;
    final secondaryColor = palette.secondaryForUI;

    final gradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.transparent,
    primaryColor.withOpacity(0.2),
  ],
);

    return DecoratedBox(
      decoration: BoxDecoration(gradient: gradient),
    );
  }
}