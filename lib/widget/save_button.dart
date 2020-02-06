import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final Function() onPressed;
  final String label;

  const SaveButton({Key key, this.onPressed, this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.5, left: 5.0, right: 5.0),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.save),
            Padding(
              padding: EdgeInsets.all(5),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
        fillColor: Colors.blue,
      ),
    );
  }
}
