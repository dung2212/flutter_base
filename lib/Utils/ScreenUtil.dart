import 'package:FlutterBase/ThirdParty/AutoSize/auto_size.dart';
import 'package:flutter/material.dart';

class ScreenUtil {
  static bool isGetPixelRatio = false;
  static double heightTopSafeArea = 0;
  static double heightBottomSafeArea = 0;
  static double heightBottomSafeAreaKeyboard = 0;
  static double pixelRatio = 1;
  static double autoSizeRatio = 1;
  static Size? screenSize;
  static Size? screenSizeLandscape;
  static late MediaQueryData mediaQueryDataApp;

  static void initSize(BuildContext context) {
    ScreenUtil.mediaQueryDataApp = MediaQuery.of(context).copyWith(
      textScaleFactor: 1,
      size: MediaQuery.of(context).size * ScreenUtil.autoSizeRatio,
      viewInsets: MediaQuery.of(context).viewInsets * ScreenUtil.autoSizeRatio,
      viewPadding: MediaQuery.of(context).viewPadding * ScreenUtil.autoSizeRatio,
      padding: MediaQuery.of(context).padding * ScreenUtil.autoSizeRatio,
    );
  }

  static double _getPixelRatio(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return (size.width > size.height ? size.height : size.width) / AutoSizeConfig.designWidth;
  }
}
