import 'package:flutter/material.dart';

class ScrollbarWidget extends StatelessWidget {
  final Widget child;
  final ScrollbarOrientation? scrollbarOrientation;
  final ScrollController? controller;
  final bool thumbVisibility;
  final Axis scrollDirection;
  final Color? scrollColor;
  final Color? backgroundColor;
  final double? paddingHorizontal;

  const ScrollbarWidget({
    Key? key,
    required this.child,
    this.scrollbarOrientation,
    this.controller,
    this.thumbVisibility = true,
    this.scrollDirection = Axis.vertical,
    this.scrollColor,
    this.backgroundColor, this.paddingHorizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);

    if (scrollDirection == Axis.vertical) {
      return MediaQuery(
        data: data.copyWith(padding: EdgeInsets.fromLTRB(0, 0, 0, 0)),
        child: Scrollbar(
          scrollbarOrientation: scrollbarOrientation,
          controller: controller,
          thumbVisibility: thumbVisibility,
          child: child,
          thickness: 3,
        ),
      );
    } else {
      final double padding = paddingHorizontal ?? 150;
      return Stack(
        children: [
          Positioned(
            left: padding,
            right: padding,
            bottom: 0,
            child: Container(
              height: 3,
              decoration: BoxDecoration(color: backgroundColor ?? Colors.grey.withOpacity(0.5), borderRadius: BorderRadius.circular(1.5)),
            ),
          ),
          MediaQuery(
            data: data.copyWith(padding: EdgeInsets.fromLTRB(padding, 0, padding, 0)),
            child: RawScrollbar(
              scrollbarOrientation: scrollbarOrientation,
              controller: controller,
              thumbVisibility: thumbVisibility,
              child: child,
              thickness: 3,
              thumbColor: scrollColor,
              radius: Radius.circular(1.5),
            ),
          ),
        ],
      );
    }
  }
}
