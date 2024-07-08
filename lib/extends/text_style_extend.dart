import 'package:flutter/material.dart';
import 'package:flutter_base/extends/double_extend.dart';

extension TextStyleExtend on TextStyle {
  TextStyle figmaHeight(double height) {
    return this.copyWith(height: height.toFigmaHeight(this.fontSize ?? 14));
  }
}
