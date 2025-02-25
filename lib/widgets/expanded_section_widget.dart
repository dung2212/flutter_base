import 'package:flutter/material.dart';

class ExpandedSectionWidget extends StatefulWidget {
  final Widget child;
  final bool expand;

  ExpandedSectionWidget({this.expand = false, required this.child});

  @override
  _ExpandedSectionWidgetState createState() => _ExpandedSectionWidgetState();
}

class _ExpandedSectionWidgetState extends State<ExpandedSectionWidget> with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    var curve = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
    if (widget.expand) {
      expandController.forward();
    }
  }

  @override
  void didUpdateWidget(ExpandedSectionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
