import 'package:flutter/material.dart';

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // Draw two interlocking circles (simplified version)
    final path = Path();

    // Left circle
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.35, size.height * 0.5), radius: size.width * 0.2));

    // Right circle
    path.addOval(Rect.fromCircle(center: Offset(size.width * 0.65, size.height * 0.5), radius: size.width * 0.2));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
