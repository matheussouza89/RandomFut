import 'dart:math';
import 'package:flutter/material.dart';

class CampoSuperior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.green),
      child: CustomPaint(
        painter: CampoSup(),
      ),
    );
  }
}

class CampoSup extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint retangulo = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0;

    Path path = Path();
    path.addRect(Rect.fromLTWH(6, 6, size.width - 12, size.height - 12));

    Path secondPath = Path();
    secondPath.addRect(Rect.fromLTWH(
        (size.width / 8), 0.0, (size.width) - (size.width / 4), 200.0));
    path.addPath(secondPath, Offset(0.0, 0.0));

    Path thirdPath = Path();
    thirdPath
        .addRect(Rect.fromLTWH((size.width / 4), 0.0, (size.width / 2), 150.0));
    path.addPath(thirdPath, Offset(0, 0));

    Path forthPath = Path();
    forthPath.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height), radius: 150));
    path.addPath(forthPath, Offset(0, 0));

    num degToRad(num deg) => deg * (pi / 180.0);
    Path fifthPath = Path();
    path.addArc(
        Rect.fromLTWH((size.width / 2) - ((size.width / 4) / 2), 150,
            size.width / 4, size.width / 4),
        degToRad(-180),
        degToRad(-180));
    path.addPath(fifthPath, Offset(0, 0));

    canvas.drawPath(path, retangulo);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
