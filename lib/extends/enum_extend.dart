import 'package:flutter_base/third_party/enum_to_string/enum_to_string.dart';

extension StringExtend on Enum {
  String convertToString() {
    return EnumToString.convertToString(this);
  }
}
