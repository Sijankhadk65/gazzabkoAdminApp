import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerItem extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const DrawerItem(
      {Key key,
      this.title,
      this.subtitle,
      this.icon,
      this.color,
      this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
      child: RawMaterialButton(
        fillColor: Colors.white,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        onPressed: onPressed,
        child: ListTile(
          leading: Icon(
            icon,
            color: color,
            size: 25,
          ),
          title: Text(
            "$title",
            style: GoogleFonts.playfairDisplay(fontSize: 25),
          ),
          subtitle: Text(
            "$subtitle",
            style: GoogleFonts.quicksand(
                fontWeight: FontWeight.bold,
                color: Colors.black38,
                fontSize: 12),
          ),
        ),
      ),
    );
  }
}
