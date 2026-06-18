import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PosterSectionSkeleton extends StatelessWidget {
  const PosterSectionSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    // Altura real: 320. Cada card: AspectRatio 2/3 con margin 12 en todos lados
    // card height disponible = 320 - 24 (margin top+bottom) = 296
    // card width = 296 * 2/3 = ~197... pero con margin horizontal queda visible ~173
    const listHeight = 320.0;
    const cardHeight = listHeight - 24; // margin top + bottom
    const cardWidth = cardHeight * 2 / 3;

    return Shimmer.fromColors(
      baseColor: Colors.grey[850]!,
      highlightColor: Colors.grey[700]!,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16,),
              child: Container(
                width: 100,
                height: 20,
                decoration: BoxDecoration(
                  
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: listHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (_, __) => Container(
                  width: cardWidth,
                  height: cardHeight,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}