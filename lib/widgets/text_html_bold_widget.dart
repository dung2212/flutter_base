import 'package:flutter/material.dart';

class TextHtmlBoldWidget extends StatelessWidget {
  final String content;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLine;
  final TextOverflow overflow;

  const TextHtmlBoldWidget(this.content, {Key? key, this.style, this.textAlign, this.maxLine, this.overflow = TextOverflow.clip}) : super(key: key);

  TextStyle _getTextStyle() {
    return style ?? const TextStyle(fontSize: 16);
  }

  @override
  Widget build(BuildContext context) {
    RegExp exp = RegExp("(?=<b)|(?<=/b>)");
    List<String> parts = content.split(exp);
    List<TextSpan> textSpans = parts.map((part) {
      if (part.contains('<b>')) {
        // Phần text đậm
        return TextSpan(
          text: part.replaceAll(RegExp(r'<\/?b>'), ''), // Bỏ thẻ <b> và </b>
          style: _getTextStyle().copyWith(fontWeight: FontWeight.w600, color: Colors.black),
        );
      } else {
        // Phần text thường
        return TextSpan(
          text: part,
          style: _getTextStyle().copyWith(color: Colors.black),
        );
      }
    }).toList();

    return RichText(
      maxLines: maxLine,
      overflow: overflow,
      textAlign: textAlign ?? TextAlign.start,
      text: TextSpan(
        children: textSpans,
      ),
    );
  }
}
