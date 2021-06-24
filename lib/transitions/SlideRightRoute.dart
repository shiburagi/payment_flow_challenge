import 'package:flutter/material.dart';

class SlideRightRoute extends PageRouteBuilder {
  final Widget? widget;

  SlideRightRoute({this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget!;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return new SlideTransition(
            position: new Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        });
}

class SlideLeftRoute extends PageRouteBuilder {
  final Widget? widget;

  SlideLeftRoute({this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return widget!;
  }, transitionsBuilder: (BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
          opacity: new Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: child),
    );
  },);
}


class SlideTopRoute extends PageRouteBuilder {
  final Widget? widget;

  SlideTopRoute({this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return widget!;
  }, transitionsBuilder: (BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return new SlideTransition(
      position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
          opacity: new Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: child),
    );
  },);
}

class RippleEffectRoute extends PageRouteBuilder {
  final Widget? widget;

  RippleEffectRoute({this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return widget!;
        }, transitionsBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child) {
          return new ScaleTransition(
            scale: new Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: FadeTransition(
                opacity: new Tween<double>(
                  begin: 0,
                  end: 1,
                ).animate(animation),
                child: child),
          );
        });
}
