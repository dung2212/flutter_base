import '../../flutter_device_type/flutter_device_type.dart';

/// Auto Size Config.
class AutoSizeConfig {
  ///  width 默认设计稿  尺寸dp or pt。
  static double _designWidth = 360;
  static bool isTablet = false;
  static bool isFixWidth = false;

  static double get designWidth {
    return _designWidth;
  }

  /// 配置设计稿尺寸 屏幕 宽，高.
  /// Configuration design draft size  screen width, height, density.
  static void setDesignWH({double width = 375, double tabletWidth = 700, bool isFixWidth = false}) {
    AutoSizeConfig.isFixWidth = isFixWidth;
    if (isFixWidth) {
      _designWidth = width;
    } else {
      isTablet = Device.get().isTablet;
      if (Device.get().isTablet) {
        _designWidth = tabletWidth;
      } else {
        _designWidth = width;
      }
    }
  }
}
