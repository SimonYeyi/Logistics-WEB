import 'package:flutter/material.dart';

Color hexColor(
  String value, {
  double opacity = 1.0,
}) {
  return Color(int.parse('0xFF' + value.replaceFirst('#', '')))
      .withOpacity(opacity);
}
