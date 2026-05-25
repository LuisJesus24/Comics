// lib/presentation/widgets/movies/components/palette_background.dart
import 'package:flutter/material.dart';
import 'package:comics/domain/entities/palette_data.dart';

class PaletteBackground extends StatelessWidget {
  final PaletteData palette;
  final Widget child;

  const PaletteBackground({
    super.key,
    required this.palette,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentGeometry.bottomCenter,
          colors: [
            palette.vibrant?.withOpacity(0.25) ?? Colors.blue.withOpacity(0.25),
            palette.lightVibrant?.withOpacity(0.15) ?? Colors.blue.shade200.withOpacity(0.15),
            palette.muted?.withOpacity(0.1) ?? Colors.grey.withOpacity(0.1),
            Colors.black,
          ],
          stops: const [0.0, 0.4, 0.7, 1.0],
        ),
      ),
      child: child,
    );
  }
}