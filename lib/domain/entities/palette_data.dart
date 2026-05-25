// lib/domain/entities/palette_data.dart
import 'package:flutter/material.dart';

class PaletteData {
  final Color? dominant;
  final Color? vibrant;
  final Color? lightVibrant;
  final Color? darkVibrant;
  final Color? muted;
  final Color? lightMuted;
  final Color? darkMuted;

  PaletteData({
    this.dominant,
    this.vibrant,
    this.lightVibrant,
    this.darkVibrant,
    this.muted,
    this.lightMuted,
    this.darkMuted,
  });

  // Método auxiliar para obtener los 2-3 mejores colores
  List<Color> getVibrancyGradient() {
    return [
      vibrant ?? lightVibrant ?? dominant ?? Colors.blue,
      muted ?? lightMuted ?? dominant ?? Colors.blue.shade300,
    ];
  }

  // Colores para glassmorphism con buena legibilidad
  Color get primaryForUI => vibrant ?? dominant ?? Colors.blue;
  Color get secondaryForUI => lightVibrant ?? muted ?? Colors.blue.shade300;
}