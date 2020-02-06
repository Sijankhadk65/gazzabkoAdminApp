import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;

  const DrawerMenuItem({Key key, this.name, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 0.0,
        fillColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.supervised_user_circle,
                size: 20,
              ),
              Container(
                width: 10,
              ),
              Text(
                "$name",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
