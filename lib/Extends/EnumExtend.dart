import 'package:FlutterBase/ThirdParty/EnumToString/enum_to_string.dart';

extension StringExtend on Enum {
  String convertToString() {
    return EnumToString.convertToString(this);
  }
}
