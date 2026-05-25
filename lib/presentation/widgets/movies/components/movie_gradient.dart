import 'package:flutter/material.dart';

class MovieGradient extends StatelessWidget {
  final Color accentColor;

  const MovieGradient({super.key, this.accentColor = Colors.transparent});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            accentColor.withOpacity(0.4),
            Colors.black87,
            Colors.black,
          ],
          stops: const [0.0, 0.5, 0.75, 1.0],
        ),
      ),
    );
  }
}