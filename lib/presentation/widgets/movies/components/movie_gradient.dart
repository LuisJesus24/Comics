import 'package:flutter/material.dart';

class MovieGradient extends StatelessWidget {
  const MovieGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,

          colors: [Colors.transparent, Colors.black54, Colors.black],
        ),

        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
