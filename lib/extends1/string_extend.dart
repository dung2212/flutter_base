import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/utils/util.dart';

extension StringExtend on String {
  String base64Encode() {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(this);
  }

  String base64Decode() {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    return stringToBase64.decode(this);
  }

  int? toInt() {
    return int.tryParse(this);
  }

  double? toDouble() {
    return double.tryParse(this);
  }

  num? toNum() {
    return num.tryParse(this);
  }

  //lấy giá trị từ TextInput nhập tiền
  int? toIntPrice() {
    var value = this.trim().replaceAll(",", "");
    return int.tryParse(value);
  }

  //lấy giá trị từ TextInput nhập tiền
  double? toDoublePrice() {
    var value = this.trim().replaceAll(",", "");
    return double.tryParse(value);
  }

  String toMd5() {
    return md5.convert(utf8.encode(this)).toString();
  }

  //kiểm tra string này có phải số không
  bool isNumber() {
    RegExp _numeric = RegExp(r'^-?[0-9]+$');

    /// check if the string contains only numbers
    return _numeric.hasMatch(this);
  }

  //chuyển mã hex sang color
  Color get toColor {
    return Util.hexToColor(this);
  }

  //chuyển tiếng việt sang tiếng anh
  String get toEN {
    return Util.convertVNtoEN(this);
  }
}
