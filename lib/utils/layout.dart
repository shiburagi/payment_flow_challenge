import 'package:flutter/material.dart';

class Layout {
  static Widget fill(context, {child}) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height -
            Scaffold.of(context).widget.appBar.preferredSize.height -
            MediaQuery.of(context).padding.top,
      ),
      child: child,
    );
  }
}