import 'package:flutter/material.dart';

class RadioModel<T> {
  bool isSelected;
  final String assetPath;
  final String displayText;
  final Color selectedColor;
  final T value;

  RadioModel(this.isSelected, this.assetPath, this.displayText, this.selectedColor, this.value);
}
