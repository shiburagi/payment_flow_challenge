import 'package:flutter/material.dart';

class TopBottomCurveClipper extends CustomClipper<Path> {
  var clipSize = 8.0;

  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, 0);

    var firstControlPoint = Offset(size.width / 2, 16);
    var firstEndPoint = Offset(size.width, 0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width, size.height);

    firstControlPoint = Offset(size.width / 2, size.height - 16);
    firstEndPoint = Offset(0, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TopBottomCurveClipper oldClipper) => true;
}

class LeftClipRectClipper extends CustomClipper<Path> {
  var clipSize = 8.0;

  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 2 - clipSize);
    path.lineTo(size.width - clipSize, size.height / 2);
    path.lineTo(size.width, size.height / 2 + clipSize);
    path.lineTo(size.width, size.height);

    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(LeftClipRectClipper oldClipper) => true;
}


class RadiusClipper extends CustomClipper<Path> {
  var clipSize = 8.0;

  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 2 - clipSize);
    path.lineTo(size.width - clipSize, size.height / 2);
    path.lineTo(size.width, size.height / 2 + clipSize);
    path.lineTo(size.width, size.height);

    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(LeftClipRectClipper oldClipper) => true;
}


class SquareClipper extends CustomClipper<Path> {
  var clipSize = 8.0;

  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(SquareClipper oldClipper) => true;
}
