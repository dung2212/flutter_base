import 'package:flutter/material.dart';

class DashLineWidget extends StatelessWidget {
  final Color color;
  final bool isVertical;

  const DashLineWidget({Key? key, this.color = Colors.grey, this.isVertical = false});

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return SizedBox(
        height: double.infinity,
        child: CustomPaint(
          painter: DashedLinePainter(
            color: this.color,
            isVertical: isVertical,
          ),
        ),
      );
    }
    else {
      return SizedBox(
        width: double.infinity,
        child: CustomPaint(
          painter: DashedLinePainter(
            color: this.color,
            isVertical: isVertical,
          ),
        ),
      );
    }
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final bool isVertical;

  DashedLinePainter({
    Key? key,
    required this.color,
    required this.isVertical,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 6, dashSpace = 4;
    final paint = Paint()
      ..color = this.color
      ..strokeWidth = 0.7;
    if (isVertical) {
      double startY = 0;
      while (startY < size.height - dashSpace) {
        canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
        startY += dashWidth + dashSpace;
      }
    } else {
      double startX = 0;
      while (startX < size.width - dashSpace) {
        canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
        startX += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
