import 'package:flutter/material.dart';
import 'package:flutter_base/widgets/restart_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    RestartApp(
      child: Container(),
    ),
  );
}
