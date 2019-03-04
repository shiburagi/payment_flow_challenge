import 'package:flutter/material.dart';

class CurveRightClipper extends CustomClipper<Path> {
  var clipSize = 24.0;

  @override
  Path getClip(Size size) {
    final path = Path();

    var offset1 = Offset(size.width - clipSize/2,  clipSize/3);
    var offset2 = Offset(size.width - clipSize/3,  clipSize/2);

    path.lineTo(size.width - clipSize, 0);
    path.quadraticBezierTo(offset1.dx, offset1.dy, offset2.dx, offset2.dy);
    path.lineTo( size.width, clipSize);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CurveRightClipper oldClipper) => true;
}

