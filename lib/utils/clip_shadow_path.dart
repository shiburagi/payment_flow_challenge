import 'package:flutter/material.dart';

@immutable
class ClipShadowPath extends StatelessWidget {
  ClipShadowPath({
    @required this.shadow,
    @required this.clipper,
    @required this.child,
  });

  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper,
        shadow: this.shadow,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class LeftClipRectClipper extends CustomClipper<Path> {
  var clipSize = 8.0;

  @override
  Path getClip(Size size) {
    final path = Path();
//    path.lineTo(size.width - clipSize, 0);
//    path.lineTo(size.width, clipSize);
//    path.lineTo(size.width, size.height - clipSize);
//    path.lineTo(size.width - clipSize, size.height);
//    path.lineTo(0.0, size.height);
//    path.lineTo(0.0, 0.0);

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

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    canvas.drawPath(clipper.getClip(size), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
