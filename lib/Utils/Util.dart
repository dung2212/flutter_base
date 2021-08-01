import 'dart:math';
import 'dart:ui';
import 'dart:io' show Platform;
import 'package:CenHomesPostUp/Model/DataChooseModel.dart';
import 'package:device_info/device_info.dart';
import 'package:FlutterBase/Extends/ColorExtends.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
export 'DateTimeUtil.dart';
export 'PreferUtil.dart';
import 'package:flutter/services.dart';
import 'package:FlutterBase/Utils/SecureStorageUtil.dart';
export 'package:FlutterBase/Extends/StringExtend.dart';
export 'package:FlutterBase/Extends/DoubleExtend.dart';
import 'package:path/path.dart';

typedef VoidOnAction = void Function();
typedef VoidOnActionInt = void Function(int value);

class Util {
  static Color hexToColor(String code) {
    //return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    return ColorExtends(code);
  }

  static bool stringNullOrEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  //Làm tròn
  static double round(double val, int places) {
    var mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  static bool validEmailPhone(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    if (double.tryParse(value) != null)
      return validateMobile(value);
    else
      return isEmail(value);
  }

  static bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  static bool validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static void printWrapped(String text) {
    final pattern = RegExp('.{1,500}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  static String getUnitName(
    double? value, {
    isDetail = false, //show chi tiết về đơn vị hay không
  }) {
    if (value == null) {
      return "";
    }
    var b = " tỷ";
    var m = " tr";
    var k = " ng";
    var unit = " ";
    if (isDetail) {
      b = " tỷ";
      m = " triệu";
      k = " nghìn";
      unit = " đ";
    }

    var price = value.toInt();
    var priceView = "";
    if (price >= 1000000000) {
      var priceNew = price / 1000000000;
      var priceString = doubleToString(round(priceNew, 2));
      priceView = "$priceString$b";
    } else if (price >= 1000000) {
      var priceNew = price / 1000000;
      var priceString = doubleToString(round(priceNew, 2));
      priceView = "$priceString$m";
    } else if (price >= 1000) {
      var priceNew = price / 1000;
      var priceString = doubleToString(round(priceNew, 2));
      print("priceString: $priceString");
      print("priceNew: $priceNew");

      priceView = "$priceString$k";
    } else {
      priceView = "$price$unit";
    }
    return priceView;
  }

  static String getUnitDistance(double? value) {
    if (value == null) {
      return "";
    }
    var km = "km";
    var m = "m";

    var price = value.toInt();
    var priceView = "";
    if (price >= 1000) {
      var priceNew = price / 1000;
      var priceString = doubleToString(round(priceNew, 2));
      priceView = "$priceString$km";
    } else {
      priceView = "$price$m";
    }
    return priceView;
  }

  static String doubleToString(double value) {
    return value.toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "");
  }

  static String toLowerCaseNormalType(String value) {
    var text = value.toLowerCase();
    if (value.length > 0) {
      var left = text.substring(0, 1).toUpperCase();
      var right = text.substring(1);
      text = left + right;
    }
    return text;
  }

  static String acronymString(String? text) //viết tắt
  {
    if (text == null) return '';
    if (text.length <= 1) {
      return text;
    }
    var listString = <String>[];
    var array = text.split(" ");
    for (var t in array) {
      if (t.length > 0) {
        listString.add(t.substring(0, 1));
      }
    }
    return listString.join("").trim().toUpperCase();
  }

  static Size textSize(
    String text,
    TextStyle style, {
    int maxLine = 1,
    double minWidth = 0,
    double maxWidth = double.infinity,
  }) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLine,
      textDirection: material.TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.size;
  }

  static String parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  static String getFullName(String? firstName, String? lastName) {
    lastName = lastName ?? "";
    firstName = firstName ?? "";
    var fullName = lastName.trim() + " " + firstName.trim();
    return fullName.trim();
  }

  static String getInitials(String? nameString) {
    if (nameString == null || nameString.isEmpty) return " ";

    List<String> nameArray = nameString.replaceAll(new RegExp(r"\s+\b|\b\s"), " ").split(" ");
    String initials = ((nameArray[0])[0]) + (nameArray.length == 1 ? " " : (nameArray[nameArray.length - 1])[0]);

    return initials;
  }

  static void showToast(String message) {
    Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, backgroundColor: Colors.black);
  }

  static String intToPrice(int? price) {
    if (price == null) return '0';
    final oCcy = new NumberFormat("#,###");
    var string = oCcy.format(price);
    return string.replaceAll(",", ".");
  }

  static String intToPriceDouble(dynamic price) {
    if (price == null) return '';
    final oCcy = new NumberFormat("#,###");
    var string = oCcy.format(price);
    return string.replaceAll(",", ".");
  }

  static String intToAreaDouble(dynamic price) {
    if (price == null) return '';
    return NumberFormat.currency(locale: 'eu', decimalDigits: 2, symbol: '').format(price).replaceAll(',00', '');
    final oCcy = new NumberFormat("#,##0.00", "VN");
    var string = oCcy.format(price);
    return string;
  }

  static String getUrlInString(String text) {
    final urlRegExp = new RegExp(
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
    Iterable<RegExpMatch> matches = urlRegExp.allMatches(text);
    String url = matches.isEmpty ? '' : text.substring(matches.first.start, matches.first.end);
    return !url.contains('http') && url.isNotEmpty ? 'https://' + url : url;
  }

  static bool getTagInString(String text) {
    final urlRegExp = new RegExp(r"\B@\w+");
    return urlRegExp.hasMatch(text);
  }

  static openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Util.showToast("Error");
    }
  }

  static callPhoneNumber(String phoneNumber) async {
    var url = 'tel:' + phoneNumber;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Util.showToast("Error");
    }
  }

  static String checkFileType(String fileType) {
//    switch (fileType){
//      case () :
//        break;
//    }
    return "";
  }

  static String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  static launchURL(String url, {Map<String, String>? headers}) async {
    if (!url.contains('http')) url = 'http://' + url;
    if (await canLaunch(url)) {
      await launch(
        url,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

//
//  static String getYoutubeId(String url) {
//    print("Youtube Link: $url}");
//
//    if (url.contains("youtu.be")) {
//      var array = url.split("youtu.be/");
//      if (array.length > 1) {
//        print("Youtube Id: ${array[1]}");
//        return array[1];
//      }
//    }
//    var youtubeId = YoutubePlayer.convertUrlToId(url) ?? "";
//    print("Youtube Id: $youtubeId");
//    return youtubeId;
//  }

  //bỏ dấu tiếng viejt
  static String nonUnicode(String text) {
    var textNew = text;
    var arr1 = [
      "á",
      "à",
      "ả",
      "ã",
      "ạ",
      "â",
      "ấ",
      "ầ",
      "ẩ",
      "ẫ",
      "ậ",
      "ă",
      "ắ",
      "ằ",
      "ẳ",
      "ẵ",
      "ặ",
      "đ",
      "é",
      "è",
      "ẻ",
      "ẽ",
      "ẹ",
      "ê",
      "ế",
      "ề",
      "ể",
      "ễ",
      "ệ",
      "í",
      "ì",
      "ỉ",
      "ĩ",
      "ị",
      "ó",
      "ò",
      "ỏ",
      "õ",
      "ọ",
      "ô",
      "ố",
      "ồ",
      "ổ",
      "ỗ",
      "ộ",
      "ơ",
      "ớ",
      "ờ",
      "ở",
      "ỡ",
      "ợ",
      "ú",
      "ù",
      "ủ",
      "ũ",
      "ụ",
      "ư",
      "ứ",
      "ừ",
      "ử",
      "ữ",
      "ự",
      "ý",
      "ỳ",
      "ỷ",
      "ỹ",
      "ỵ"
    ];
    var arr2 = [
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "a",
      "d",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "e",
      "i",
      "i",
      "i",
      "i",
      "i",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "o",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "u",
      "y",
      "y",
      "y",
      "y",
      "y"
    ];

    for (int i = 0; i < arr1.length; i++) {
      textNew = textNew.replaceAll(arr1[i], arr2[i]);
      textNew = textNew.replaceAll(arr1[i].toUpperCase(), arr2[i].toUpperCase());
    }
    return textNew;
  }

  static String getUnitPrice(String price) {
    print("price $price");
    var arrayTachUnit = price.split(" ");
    if (arrayTachUnit.length > 1) {
      return arrayTachUnit[1];
    }
    return "";
  }

  static String showValueDouble(double value, int places) {
    var text = roundDouble(value, places).toString().replaceAll(".0", "");
    return text;
  }

  static double roundDouble(double value, int places) {
    var mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  static String decodePhone(String phoneNumber) {
    phoneNumber = phoneNumber.replaceRange(phoneNumber.length - 3, phoneNumber.length, '***');
    return phoneNumber;
  }

  static String getFullPhoneWithCountryCode({required String countryCode, required String phoneNumber}) {
    var phone = phoneNumber;
    if (phoneNumber.length > 0) {
      var split = phoneNumber.substring(0, 1);
      if (split == "0") {
        phone = phoneNumber.substring(1, phoneNumber.length);
      }
    }
    return countryCode + phone;
  }

  static String getAvatarName(String name) {
    if (name.trim().length > 0) {
      return name.substring(0, 1);
    }
    return "";
  }

  static Color getColorAvatarRandom(String name) {
    var colors = ["#ffe9e7", "#e9f0ff", "#fcf8cd", "#edfafa", "#ecf7e5", "#fadff3", "#ececff", "#f1e5fb", "#f3f7cd", "#ffeee0"];
    var listColor1 = ["a", "b", "c", "d"];
    var listColor2 = ["e", "f", "g", "h"];
    var listColor3 = ["i", "j", "k", "l"];
    var listColor4 = ["m", "n", "o", "p"];
    var listColor5 = ["q", "r", "s", "t"];
    var listColor6 = [
      "u",
      "v",
      "w",
    ];
    var listColor7 = ["y", "z", "s"];
    var listColor8 = ["0", "1", "2", "3"];
    var listColor9 = ["4", "5", "6", "7"];
    var listColor10 = ["8", "9"];
    var firstCharName = (name.trim().isEmpty) ? '0' : name[0].toLowerCase(); //fuck

    if (listColor1.contains(firstCharName)) return hexToColor(colors[0]);
    if (listColor2.contains(firstCharName)) return hexToColor(colors[1]);
    if (listColor3.contains(firstCharName)) return hexToColor(colors[2]);
    if (listColor4.contains(firstCharName)) return hexToColor(colors[3]);
    if (listColor5.contains(firstCharName)) return hexToColor(colors[4]);
    if (listColor6.contains(firstCharName)) return hexToColor(colors[5]);
    if (listColor7.contains(firstCharName)) return hexToColor(colors[6]);
    if (listColor8.contains(firstCharName)) return hexToColor(colors[7]);
    if (listColor9.contains(firstCharName)) return hexToColor(colors[8]);
    if (listColor10.contains(firstCharName)) return hexToColor(colors[9]);
    return hexToColor(colors[0]);
  }

  static Future<String?> getDeviceIdentifier() async {
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
//        var data = await deviceInfoPlugin.iosInfo;
//        identifier = data.identifierForVendor; //UUID for iOS
        return SecureStorageUtil.deviceId ?? "";
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    //print('identifier= ' + identifier);
    return null;
  }

  //kiểm tra chữ bắt đầu trong đoạn text: Ví dụ: check chữ Dung có ở đầu câu DungDepTrai không
  static bool checkTextBegin(String? textBegin, String? textFull) {
    if (textBegin == null || textFull == null) return false;
    if (textBegin.length >= textFull.length) return textBegin == textFull;
    var cutTextFull = textFull.substring(0, textBegin.length);
    return textBegin == cutTextFull;
  }

  //kiểm tra text này có phải url không
  static bool isValidUrl(String url) {
    bool _validURL = Uri.parse(url).isAbsolute;
    return _validURL;
  }

  //lấy random String theo số lượng ký tự
  static getRandomString({required int length}) {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static String getFileExtension({required String fileName}) {
    return "";
  }

  static String getFileNameInPath({required String path}) {
    return basename(path);
  }

  static _UserNameInfo getFirstLastName(String fullName) {
    var info = _UserNameInfo();
    if (fullName.length > 0) {
      var array = fullName.split(" ");
      if (array.length <= 1) {
        info.firstName = fullName.trim();
        info.lastName = "";
      } else {
        info.firstName = array[array.length - 1];
        info.lastName = fullName.substring(0, fullName.length - info.firstName.length).trim();
      }
    }
    print("firstName: " + info.firstName);
    print("lastName: " + info.lastName);
    return info;
  }

  static String getYoutubeId({required String url}) {
    print("Youtube Link: $url}");

    if (url.contains("youtu.be")) {
      var array = url.split("youtu.be/");
      if (array.length > 1) {
        print("Youtube Id: ${array[1]}");
        return array[1];
      }
    }
    var youtubeId = _convertUrlToId(url) ?? "";
    print("Youtube Id: $youtubeId");
    return youtubeId;
  }

  static String? _convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  static List<DataChooseModel> getListTransaction() {
    List<DataChooseModel> list = [];
    list.add(DataChooseModel(title: "Chưa có giao dịch", id: "0"));
    list.add(DataChooseModel(title: "1- 5 giao dịch", id: "1-5"));
    list.add(DataChooseModel(title: "6 - 20 giao dịch", id: "6-20"));
    list.add(DataChooseModel(title: "Trên 20 giao dịch", id: "tren-20"));
    return list;
  }
  static List<DataChooseModel> getListWork() {
    List<DataChooseModel> list = [];
    list.add(DataChooseModel(title: "Chuyên viên tư vấn", id: "sale"));
    list.add(DataChooseModel(title: "Chuyên viên văn phòng", id: "office"));
    list.add(DataChooseModel(title: "Khác", id: "other"));
    return list;
  }
  static List<DataChooseModel> getListEducate() {
    List<DataChooseModel> list = [];
    list.add(DataChooseModel(title: "Trung học", id: "thpt"));
    list.add(DataChooseModel(title: "Trung cấp", id: "trung_cap"));
    list.add(DataChooseModel(title: "Cao đẳng", id: "cao_dang"));
    list.add(DataChooseModel(title: "Đại học", id: "dai_hoc"));
    list.add(DataChooseModel(title: "Khác", id: "khac"));
    return list;
  }
}

class _UserNameInfo {
  String firstName = "";
  String lastName = "";
}
