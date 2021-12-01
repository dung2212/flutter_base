import 'dart:io';

import 'package:FlutterBase/Utils/Util.dart';
import 'package:device_info/device_info.dart';

class DeviceUtil {
  static String? deviceName;
  static String? deviceVersion;
  static String? deviceId;//duy nhất khi cài app

  static Future initData() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
      deviceVersion = androidInfo.version.baseOS;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine;
      deviceVersion = iosInfo.utsname.version;
    }
    deviceId = await Util.getDeviceIdentifier();
  }
}
