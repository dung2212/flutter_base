import 'dart:ui';
import 'dart:ui' as ui;

import 'package:FlutterBase/ThirdParty/AutoSize/auto_size.dart';
import 'package:FlutterBase/Utils/DeviceUtil.dart';
import 'package:FlutterBase/Utils/FileUtil.dart';
import 'package:FlutterBase/Utils/ScreenUtil.dart';

class FlutterBase {
  static String keyEncrypt = "P@123123123";
  static Function(String? value)? OnGetLanguage;

  static init() {
    //ScreenUtil.pixelRatio = AutoSize.getPixelRatio();
    ScreenUtil.heightTopSafeArea = ui.window.viewPadding.top / ScreenUtil.pixelRatio;
    ScreenUtil.heightBottomSafeArea = ui.window.viewPadding.bottom / ScreenUtil.pixelRatio;
    DeviceUtil.initData();
    FileUtil.init();
  }

  static String? translate(String? value) {
    if (OnGetLanguage != null) {
      return OnGetLanguage?.call(value);
    }
    return value;
  }
}
