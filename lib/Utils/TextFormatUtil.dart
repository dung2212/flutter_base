import 'package:flutter/services.dart';

//Format nhận số thập phân đổi tất cả dấu phẩy thành dấu chấm
class CommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String truncated = newValue.text;
    TextSelection newSelection = newValue.selection;

    if (newValue.text.contains(",")) {
      truncated = newValue.text.replaceFirst(RegExp(','), '.');
    }
    return TextEditingValue(
      text: truncated,
      selection: newSelection,
    );
  }
}

//Chỉ nhận số nguyên dương
//WhitelistingTextInputFormatter.digitsOnly
TextInputFormatter NumberTextInputFormatter() {
  return FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
}
// class NumberTextInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//     String truncated = newValue.text;
//     TextSelection newSelection = newValue.selection;
//
//     if (newValue.text.contains(",")) {
//       truncated = newValue.text.replaceFirst(RegExp(','), '');
//     }
//     if (newValue.text.contains(".")) {
//       truncated = newValue.text.replaceFirst(RegExp('.'), '');
//     }
//     return TextEditingValue(
//       text: truncated,
//       selection: newSelection,
//     );
//     WhitelistingTextInputFormatter.digitsOnly
//   }
// }
