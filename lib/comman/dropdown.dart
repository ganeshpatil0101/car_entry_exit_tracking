import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiver/strings.dart';

class Dropdown extends StatefulWidget {
  final Function(String) onChange;
  final String hintText;
  final defaultValue;
  final List<String> options;
  Dropdown(
      {@required this.onChange,
      @required this.hintText,
      @required this.defaultValue,
      @required this.options});

  @override
  State<StatefulWidget> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  // final _focus = FocusNode();
  // final _controller;

  // bool focused = false;

  //_DropdownState();

  @override
  void initState() {
    // _controller.addListener(() => handleChange());
    // _focus.addListener(() => focused = !focused);
    super.initState();
  }

  @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  // void handleChange() {
  //   var number = _controller.text;
  //   widget.onChange(isBlank(number) ? null : double.parse(number));
  // }

  // bool isClearable() {
  //   return !isBlank(_controller.text);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          border: Border.all(
              color: Colors.grey, style: BorderStyle.solid, width: 1.2),
        ),
        child: DropdownButton<String>(
          value: widget.defaultValue,
          isExpanded: true,
          hint: Text(widget.hintText),
          underline: Container(
            color: Colors.deepPurpleAccent,
          ),
          onChanged: widget.onChange,
          items: widget.options.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
  }
}
