import 'package:flutter/material.dart';

class SwipeActionStyle {
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderRadius borderRadius;
  final double width;

  const SwipeActionStyle({
    this.backgroundColor = Colors.red,
    this.foregroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.width = 80,
  });
}