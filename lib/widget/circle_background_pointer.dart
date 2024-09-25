import 'package:flutter/material.dart';
class CircleBackgroundPainterWidget extends CustomPainter {
  final Color color;
  final double topLeftRadius;
  final double bottomLeftRadius;

  CircleBackgroundPainterWidget({
    required this.color,
    this.topLeftRadius = 100.0, // Default radius untuk lingkaran di kiri atas
    this.bottomLeftRadius = 150.0, // Default radius untuk lingkaran di bawah
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.2) // Warna lingkaran
      ..style = PaintingStyle.fill;

    // Menggambar lingkaran di pojok kiri atas
    canvas.drawCircle(
      const Offset(0, 0), // Posisi lingkaran
      topLeftRadius, // Radius lingkaran
      paint,
    );

    // Menggambar lingkaran di bagian bawah kanan
    canvas.drawCircle(
      Offset(size.width, size.height), // Posisi lingkaran
      bottomLeftRadius, // Radius lingkaran
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CircleBackgroundWidget extends StatelessWidget {
  final Widget child;
  final Color color;
  final double topRightRadius;
  final double bottomLeftRadius;

  const CircleBackgroundWidget({
    super.key,
    required this.child,
    this.color = Colors.green,
    this.topRightRadius = 100.0,
    this.bottomLeftRadius = 150.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircleBackgroundPainterWidget(
        color: color,
        topLeftRadius: topRightRadius,
        bottomLeftRadius: bottomLeftRadius,
      ),
      child: child,
    );
  }
}