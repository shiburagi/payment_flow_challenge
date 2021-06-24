import 'dart:async';

import 'package:flutter/material.dart';

class CountDownView extends StatefulWidget {
  CountDownView({this.minutes = 0, this.seconds = 0, Key? key})
      : super(key: key);

  final int minutes;
  final int seconds;

  @override
  _CountDownViewState createState() {
    return _CountDownViewState();
  }
}

class _CountDownViewState extends State<CountDownView> {
  int totalSeconds = 0;

  late Timer timer;

  @override
  void initState() {
    super.initState();
    totalSeconds = widget.minutes * 60 + widget.seconds;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        totalSeconds--;
      });
      if (totalSeconds == 0) timer.cancel();
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Text(getTime());
  }

  String getTime() {
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60).floor();

    return "$minutes:$seconds";
  }
}
