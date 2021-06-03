import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

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

//Giới hạn ký tự MaxLenght
class LengthLimitingTextFieldFormatterFixed extends LengthLimitingTextInputFormatter {
  LengthLimitingTextFieldFormatterFixed(int? maxLength) : super(maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength != null && maxLength! > 0 && newValue.text.characters.length > maxLength!) {
      // If already at the maximum and tried to enter even more, keep the old
      // value.
      if (oldValue.text.characters.length == maxLength) {
        return oldValue;
      }
      // ignore: invalid_use_of_visible_for_testing_member
      return LengthLimitingTextInputFormatter.truncate(newValue, maxLength!);
    }
    return newValue;
  }
}
