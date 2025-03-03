import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A class that extends the [CustomPainter] to paint the requested circle
/// First two define the  animated value and up value. Other ones for
/// controlling the animation moves.
/// Also this class has [backgroundColor] and [progressColor] to control these colors.
class CirclePainter extends CustomPainter {
  final Color? progressColor;
  final Color? backgroundColor;
  final double progressNumber;
  final double lastProgressNumber;
  final int maxNumber;
  final double fraction;
  final Paint _paint;

  /// The [CirclePainter] constructor has four required parameters that are [progressNumber],
  /// [maxNumber], [fraction] and [animation].
  CirclePainter({
    required this.progressNumber,
    required this.lastProgressNumber,
    required this.maxNumber,
    required this.fraction,
    this.backgroundColor,
    this.progressColor,
  }) : _paint = Paint()
          ..color = Colors.white
          ..strokeWidth = 10.0
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round;

  /// The [paint] method is called whenever the custom object needs to be repainted.
  /// This method make actual painting according to given values.
  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = backgroundColor ?? Colors.black12;
    canvas.drawArc(Offset.zero & size, -math.pi, 2 * math.pi, false, _paint);

    _paint.color = progressColor ?? Colors.blue;

    double lastPercent = lastProgressNumber / maxNumber;
    double expectPercent = progressNumber / maxNumber;
    double realtimePercent = fraction * (expectPercent - lastPercent) + lastPercent;
    double progressRadians = realtimePercent * (2 * math.pi);

    double startAngle = -math.pi * 1.5;

    canvas.drawArc(
        Offset.zero & size, startAngle, progressRadians, false, _paint);
  }

  /// The [shouldRepaint] method is called when a new instance of the class
  /// is provided, to check if the new instance actually represents different
  /// information.
  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}
