import 'package:flutter/material.dart';

class BluePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    final Paint paint = Paint();

    final Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, width, height));
    paint.color = const Color(0xFF1B2E44); //Colors.blue.shade700;
    // paint.maskFilter = MaskFilter.blur(BlurStyle.normal, 10.0);
    canvas.drawPath(mainBackground, paint);

    final Path ovalPath = Path();
    // start paint from 20% height to the left
    ovalPath.moveTo(0, height * 0.1);
    // paint a curve from current position to the middle of the screen
    ovalPath.quadraticBezierTo(
        width * 0.45, height * 0.25, width / 2, height / 2);
    paint.color = const Color(0xFF183453);
    // paint a curve from the current position to the bottom left of the screen * 0.1
    ovalPath.quadraticBezierTo(width * 0.58, height * 0.8, width * 0.1, height);
    // draw remaining line from the current position to the lower left corner
    ovalPath.lineTo(0, height);
    // close line to reset it

    ovalPath.close();
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(BluePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BluePainter oldDelegate) => false;
}
