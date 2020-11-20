import 'dart:ui';
import 'dart:ui' as ui;

import 'package:FlutterBase/ThirdParty/AutoSize/auto_size.dart';
import 'package:FlutterBase/Utils/ScreenUtil.dart';

class FlutterBase {
  static String keyEncrypt;

  static init() {
    ScreenUtil.heightTopSafeArea = ui.window.viewPadding.top / AutoSize.getPixelRatio();
    ScreenUtil.heightBottomSafeArea = ui.window.viewPadding.bottom / AutoSize.getPixelRatio();
    print("ui.window.viewPadding.top ${ui.window.viewPadding.top}");
    print("ScreenUtil.heightTopSafeArea ${ScreenUtil.heightTopSafeArea}");
  }

  static Size screenSize;
}
