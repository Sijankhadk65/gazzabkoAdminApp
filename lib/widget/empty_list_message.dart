import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyListMessage extends StatelessWidget {
  final String message;

  const EmptyListMessage({Key key, @required this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SvgPicture.asset(
          "assets/svg/sad.svg",
          height: 200,
          width: 200,
        ),
        Text(
          message,
          style: GoogleFonts.playfairDisplay(fontSize: 25),
        ),
      ],
    ));
  }
}
