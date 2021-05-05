import 'dart:convert';
import 'package:crypto/crypto.dart';

extension StringExtend on String {
  String base64Encode() {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(this);
  }

  String base64Decode() {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.decode(this);
  }

  int toInt() {
    if (this == null) return null;
    return int.tryParse(this);
  }

  String toMd5() {
    return md5.convert(utf8.encode(this)).toString();
  }
}
