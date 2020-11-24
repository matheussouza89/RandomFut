import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:randomfut/pages/sorteadosCas.dart';

class CampoInferior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    changePage(context);
    return Container(
      decoration: BoxDecoration(color: Colors.green),
      child: CustomPaint(
        painter: CampoInf(),
      ),
    );
  }
}

class CampoInf extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint retangulo = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0;

    Path path = Path();
    path.addRect(Rect.fromLTWH(6, 6, size.width - 12, size.height - 12));

    Path secondPath = Path();
    secondPath.addRect(Rect.fromLTWH((size.width / 8), size.height - 200,
        (size.width) - (size.width / 4), size.height));
    path.addPath(secondPath, Offset(0.0, 0.0));

    Path thirdPath = Path();
    thirdPath.addRect(Rect.fromLTWH(
        (size.width / 4), size.height - 150, (size.width / 2), size.height));
    path.addPath(thirdPath, Offset(0, 0));

    Path forthPath = Path();
    forthPath.addOval(
        Rect.fromCircle(center: Offset(size.width / 2, 0), radius: 150));
    path.addPath(forthPath, Offset(0, 0));

    num degToRad(num deg) => deg * (pi / 180.0);
    Path fifthPath = Path();
    path.addArc(
        Rect.fromLTWH(
            (size.width / 2) - ((size.width / 4) / 2),
            size.height - (150 + (size.width / 4)),
            size.width / 4,
            size.width / 4),
        degToRad(180),
        degToRad(180));
    path.addPath(fifthPath, Offset(0, 0));

    canvas.drawPath(path, retangulo);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

changePage(context) {
  int i = 0;
  Timer.periodic(Duration(seconds: 1), (timer) {
    i++;
    if (i == 1) {
      timer.cancel();
      Navigator.of(context).pop();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SorteadosCas()));
    }
    print(i);
  });
}
