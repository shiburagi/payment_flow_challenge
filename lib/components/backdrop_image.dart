import 'dart:ui';

import 'package:flutter/material.dart';

class BackdropImage extends StatelessWidget {
  BackdropImage({this.image, this.child, Key? key}) : super(key: key);

  final ImageProvider? image;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: image!,
          fit: BoxFit.cover,
        ),
      ),
      child: new BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: child,
      ),
    );
  }
}
