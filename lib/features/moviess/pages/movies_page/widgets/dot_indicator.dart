import 'package:flutter/material.dart';

const primaryColor = Color(0xFF006BF3);

class DotIndicator extends Decoration {
  const DotIndicator();

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return const DotIndicatorPainter();
  }
}

class DotIndicatorPainter extends BoxPainter {
  const DotIndicatorPainter();

  static const radius = 5.0;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final dx = configuration.size!.width / 2;
    final dy = configuration.size!.height + radius / 10;
    final c = offset + Offset(dx, dy);

    final paint = Paint()..color = primaryColor;

    canvas.drawCircle(c, radius, paint);
  }
}
