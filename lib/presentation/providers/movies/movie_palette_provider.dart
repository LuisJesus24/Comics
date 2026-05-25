// lib/presentation/providers/movies/movie_palette_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:comics/domain/entities/palette_data.dart';

final moviePaletteProvider = 
  FutureProvider.family<PaletteData, String>((ref, imageUrl) async {
  if (imageUrl.isEmpty) {
    return PaletteData(); // Paleta vacía como fallback
  }

  try {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(imageUrl),
      maximumColorCount: 32, // Más colores para mejor análisis
      timeout: const Duration(seconds: 5),
    );

    return PaletteData(
      dominant: paletteGenerator.dominantColor?.color,
      vibrant: paletteGenerator.vibrantColor?.color,
      lightVibrant: paletteGenerator.lightVibrantColor?.color,
      darkVibrant: paletteGenerator.darkVibrantColor?.color,
      muted: paletteGenerator.mutedColor?.color,
      lightMuted: paletteGenerator.lightMutedColor?.color,
      darkMuted: paletteGenerator.darkMutedColor?.color,
    );
  } catch (e) {
    print('❌ Error en paletteProvider: $e');
    return PaletteData();
  }
});