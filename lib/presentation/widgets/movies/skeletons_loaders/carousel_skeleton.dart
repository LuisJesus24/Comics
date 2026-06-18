import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CarouselSkeleton extends StatelessWidget {
  const CarouselSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.8; // viewportFraction: 0.8

    return Shimmer.fromColors(
      baseColor: Colors.grey[850]!,
      highlightColor: Colors.grey[700]!,
      child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.6,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Tarjeta lateral izquierda
                Positioned(
                  left: 0,
                  top: 10,
                  bottom: 10,
                  width: screenWidth * 0.15,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                // Tarjeta central con borde blanco
                Container(
                  width: cardWidth,
                  margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                ),
                // Tarjeta lateral derecha
                Positioned(
                  right: 0,
                  top: 10,
                  bottom: 10,
                  width: screenWidth * 0.15,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (i) =>
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: i == 0 ? 16 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}