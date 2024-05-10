import 'package:flutter/material.dart';
import 'package:you_do/src/core/theme/theme_extension.dart';

class WeeklyProgressBox extends StatelessWidget {
  const WeeklyProgressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      color: context.theme.cardColor,
      child: Stack(children: [
        Container(
          height: 175,
          width: size.width - 60,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        ),
        CustomPaint(
          painter: WeeklyProgressBoxPainter(context.theme.primaryColor),
          size: Size(size.width, 175),
        )
      ]),
    );
  }
}

class WeeklyProgressBoxPainter extends CustomPainter {
  Color color;
  WeeklyProgressBoxPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(size.width * .75, size.height * .97);
    path.lineTo(size.width * .73, size.height);
    path.quadraticBezierTo(
        size.width * .85, size.height / 2, size.width * .75, size.height * .03);
    path.lineTo(size.width * .73, 0);
    path.lineTo(size.width * .945, 0);
    path.quadraticBezierTo(
        size.width, size.height * .035, size.width, size.height * .15);
    path.lineTo(size.width, size.height * .85);
    path.quadraticBezierTo(
        size.width, size.height, size.width * .945, size.height);
    path.lineTo(size.width * .73, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
