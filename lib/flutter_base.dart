import 'dart:ui';
import 'dart:ui' as ui;

import 'utils/device_util.dart';
import 'utils/file_util.dart';
import 'utils/screen_util.dart';

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
