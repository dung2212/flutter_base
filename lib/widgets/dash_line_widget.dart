import 'package:flutter/material.dart';

class DashLineWidget extends StatelessWidget {
  final Color color;
  final bool isVertical;
  final double? widthLine;

  const DashLineWidget({Key? key, this.color = Colors.grey, this.isVertical = false, this.widthLine});

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return SizedBox(
        height: double.infinity,
        child: CustomPaint(
          painter: DashedLinePainter(
            color: this.color,
            isVertical: isVertical,
            widthLine: widthLine,
          ),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: CustomPaint(
          painter: DashedLinePainter(
            color: this.color,
            isVertical: isVertical,
            widthLine: widthLine,
          ),
        ),
      );
    }
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final bool isVertical;
  final double? widthLine;

  DashedLinePainter({
    Key? key,
    required this.color,
    required this.isVertical,
    required this.widthLine,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 6, dashSpace = 4;
    final paint = Paint()
      ..color = this.color
      ..strokeWidth = (widthLine ?? 0.7) / 2;
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
