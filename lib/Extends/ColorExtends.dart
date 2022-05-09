import 'dart:ui';

import 'package:FlutterBase/Utils/Util.dart';

class ColorExtends extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  ColorExtends(final String hexColor) : super(_getColorFromHex(hexColor));

  //chuyển màu sang mã hext
  String toHex({
    bool leadingHashSign = true,//có hiển thị dấu #
    bool isShowAlpha = true,//có hiển thị mã alpha
  }) {
    return Util.colorToHex(this, leadingHashSign: leadingHashSign, isShowAlpha: isShowAlpha);
  }
}
