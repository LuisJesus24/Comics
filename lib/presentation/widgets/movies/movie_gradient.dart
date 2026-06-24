import 'package:flutter/material.dart';

class MovieGradient {
  
  static LinearGradient bottomCenter =
    const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.transparent,
        Colors.black
      ],
      stops: [
        0.5,
        1.0
      ]
    );
  

  static LinearGradient topLeft =
    const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.black87,
        Colors.black26,
        Colors.transparent,
      ],
      stops: [
        0.01,
        0.05,
        0.35
      ]
    );
  
  static LinearGradient topRight =
    const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.black87,
        Colors.black26,
        Colors.transparent,
      ],
      stops: [
        0.01,
        0.05,
        0.35
      ]
    );
}