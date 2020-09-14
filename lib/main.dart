/// For HTML:
/// import 'package:adonis_websok/html.dart';
///
/// For IO (Flutter, Dart, etc.)
//
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'Widget/RestartApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    RestartApp(
      child: DevicePreview(
        enabled: false,
        builder: (context) => Container(),
      ),
    ),
  );
}


