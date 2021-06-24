import 'package:flutter/material.dart';

class NumberTextInput extends StatefulWidget {
  NumberTextInput({this.hintText, this.controller, Key? key}) : super(key: key);
  final String? hintText;
  final TextEditingController? controller;

  @override
  State<StatefulWidget> createState() {
    return _NumberTextInputState();
  }
}

class _NumberTextInputState extends State<NumberTextInput> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = widget.controller ?? _controller;
    int value = int.tryParse(controller.text) ?? 0;
    var border = OutlineInputBorder(
        borderSide: BorderSide(width: 0, color: Colors.transparent));
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.remove),
              onPressed: value == 0
                  ? null
                  : () {
                      setState(() {
                        value--;
                        controller.text = value.toString();
                      });
                    }),
          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                  border: border,
                  focusedBorder: border,
                  enabledBorder: border),
            ),
            flex: 1,
          ),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  value++;
                  controller.text = value.toString();
                });
              }),
        ],
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }
}
