import 'package:flutter/material.dart';

class InputFields extends StatefulWidget {
  final void Function(String) onChanged;
  final String hintText, errorText, label;
  final double bottomPadding;
  final TextEditingController controller;
  final int maxLinesCount;
  final TextInputType type;

  const InputFields({
    Key key,
    this.onChanged,
    this.hintText,
    this.errorText,
    this.label,
    this.bottomPadding = 0,
    this.controller,
    this.maxLinesCount = 1,
    this.type = TextInputType.text,
  }) : super(key: key);

  @override
  _InputFieldsState createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              widget.label,
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            ),
          ),
          SizedBox.fromSize(
            size: Size.fromHeight(5),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, bottom: widget.bottomPadding),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFC2C2C2),
                      blurRadius: 10.0,
                      offset: Offset(0, 8))
                ]),
            child: TextField(
              keyboardType: widget.type,
              maxLines: widget.maxLinesCount,
              controller: widget.controller,
              onChanged: widget.onChanged,
              style: TextStyle(fontFamily: "Oswald"),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  errorText: widget.errorText,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(color: Color(0xFFCAC9C9))),
            ),
          ),
        ],
      ),
    );
  }
}
