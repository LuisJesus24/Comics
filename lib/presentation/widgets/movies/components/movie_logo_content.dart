import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieLogoContent extends StatelessWidget {
  final String? logoUrl;
  final String title;

  final double width;
  final double height;
  final double fontSize;

  const MovieLogoContent({
    super.key,
    required this.logoUrl,
    required this.title,
    required this.width,
    required this.height,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final hasLogo = logoUrl != null && logoUrl!.isNotEmpty;

    return SizedBox(
      width: width,
      height: height,

      child: Align(
        alignment: Alignment.bottomLeft,

        child: hasLogo
            ? FadeInDown(
                child: CachedNetworkImage(
                  imageUrl: logoUrl!,

                  fit: BoxFit.contain,

                  fadeInDuration: Duration.zero,

                  placeholder: (_, __) {
                    return SizedBox(width: width, height: height);
                  },
                ),
              )
            : FadeInDown(
                child: Text(
                  title,

                  maxLines: 2,

                  overflow: TextOverflow.ellipsis,

                  style: TextStyle(
                    color: Colors.white,

                    fontSize: fontSize,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}
