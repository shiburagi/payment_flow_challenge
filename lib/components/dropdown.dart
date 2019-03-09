import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  DropDown({this.items, this.hint, this.controller, Key key}) : super(key: key);

  final String hint;
  final List items;
  final DropDownController controller;

  @override
  State<StatefulWidget> createState() {
    return _DropDownState();
  }
}

class _DropDownState extends State<DropDown> {
  DropDownController defaultController = DropDownController();

  @override
  Widget build(BuildContext context) {
    DropDownController controller = widget?.controller ?? defaultController;

    var border = OutlineInputBorder(
      borderSide: BorderSide(
        width: 0,
        color: Colors.transparent,
      ),
    );
    return DropdownButtonFormField<String>(
      value: controller.value,
      hint: Text(widget.hint),
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(left: 70, right: 12, top: 16, bottom: 16),
        border: border,
        enabledBorder: border,
      ),
      onChanged: (String newValue) {
        setState(() {
          controller.value = newValue;
        });
      },
      items: (widget.items).map((value) {
        return DropdownMenuItem<String>(
          value: value.toString(),
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DropDownController {
  DropDownController({this.value});

  String value;
}
