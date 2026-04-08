import 'package:flutter/material.dart';
import 'swipe_action_style.dart';

class SwipeActionButton {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final SwipeActionStyle style;

  SwipeActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.style = const SwipeActionStyle(),
  });
}