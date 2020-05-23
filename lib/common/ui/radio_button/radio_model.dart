import 'package:flutter/material.dart';

class RadioModel {
  bool isSelected;
  final String assetPath;
  final String text;
  final Color selectedColor;

  RadioModel(this.isSelected, this.assetPath, this.text, this.selectedColor);
}
