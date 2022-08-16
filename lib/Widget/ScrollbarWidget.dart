import 'package:flutter/material.dart';

class ScrollbarWidget extends StatelessWidget {
  final Widget child;
  final ScrollbarOrientation? scrollbarOrientation;
  final ScrollController? controller;
  final bool thumbVisibility;
  final Axis scrollDirection;

  const ScrollbarWidget({
    Key? key,
    required this.child,
    this.scrollbarOrientation,
    this.controller,
    this.thumbVisibility = true,
    this.scrollDirection = Axis.vertical,
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
      final double padding = 150;
      return Stack(
        children: [
          MediaQuery(
            data: data.copyWith(padding: EdgeInsets.fromLTRB(padding, 0, padding, 0)),
            child: Scrollbar(
              scrollbarOrientation: scrollbarOrientation,
              controller: controller,
              thumbVisibility: thumbVisibility,
              child: child,
              thickness: 3,
            ),
          ),
          Positioned(
            left: padding + 2,
            right: padding + 2,
            bottom: 3,
            child: Container(
              height: 3,
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5), borderRadius: BorderRadius.circular(1.5)),
            ),
          )
        ],
      );
    }
  }
}
