import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/login_bloc.dart';
import 'package:gazzabko_admin_app/bloc/users_bloc.dart';
import 'package:gazzabko_admin_app/model/user.dart';
import 'package:gazzabko_admin_app/screen/add_user.dart';
import 'package:gazzabko_admin_app/screen/profile_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileCard extends StatelessWidget {
  final User user;

  final String amdinEmail;

  const ProfileCard({Key key, this.user, this.amdinEmail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color(0Xff1B4F7F),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 5), blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(5)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => Provider(
                        create: (_) => LoginBloc(),
                        child: ProfileScreen(
                          user: user,
                          job: "display",
                        ))));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/img/profile.jpg"),
                        fit: BoxFit.cover),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black45,
                          offset: Offset(2, 8),
                          blurRadius: 10)
                    ],
                    borderRadius: BorderRadius.circular(5)),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${user.name}",
                      style: GoogleFonts.playfairDisplay(
                          color: Colors.white, fontSize: 28),
                    ),
                    Text(
                      "${user.email}",
                      style: GoogleFonts.quicksand(
                          color: Colors.white, fontSize: 15),
                    ),
                    Divider(
                      color: Colors.black45,
                      thickness: 2,
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Material(
                          color: Colors.white,
                          elevation: 10,
                          borderRadius: BorderRadius.circular(5),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5.0, bottom: 5, left: 10, right: 10),
                            child: Text(
                              "${user.accType}",
                              style: GoogleFonts.oswald(),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Material(
                            color: Colors.white,
                            elevation: 10,
                            borderRadius: BorderRadius.circular(5),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, bottom: 5, left: 10, right: 10),
                              child: Text(
                                "${user.area}",
                                style: GoogleFonts.oswald(),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
