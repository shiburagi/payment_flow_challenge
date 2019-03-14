import 'package:flutter/material.dart';

@immutable
class ClipBorderPath extends StatelessWidget {
  ClipBorderPath({
    @required this.border,
    @required this.clipper,
    @required this.child,
  });

  final Border border;
  final CustomClipper<Path> clipper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: this.clipper,
        border: this.border,
      ),
      child: ClipPath(child: child, clipper: this.clipper),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Border border;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({@required this.border, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    Offset offset1 = Offset(0, 0);
    Offset offset2 = Offset(0, size.height);
    Offset offset3 = Offset(size.width, size.height);
    Offset offset4 = Offset(size.width, 0);

    canvas.drawLine(offset1, offset4, border.top.toPaint());
    canvas.drawLine(offset2, offset3, border.bottom.toPaint());
    canvas.drawLine(offset1, offset2, border.left.toPaint());
    canvas.drawLine(offset4, offset3, border.right.toPaint());

    canvas.drawPath(clipper.getClip(size), border.top.toPaint());
    canvas.drawPath(clipper.getClip(size), border.bottom.toPaint());
    canvas.drawPath(clipper.getClip(size), border.left.toPaint());
    canvas.drawPath(clipper.getClip(size), border.right.toPaint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
