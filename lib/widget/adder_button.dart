import 'package:flutter/material.dart';

class AdderButton extends StatefulWidget {
  final Function() onPressed;

  const AdderButton({Key key, @required this.onPressed}) : super(key: key);
  @override
  _AdderButtonState createState() => _AdderButtonState();
}

class _AdderButtonState extends State<AdderButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: RawMaterialButton(
        fillColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
