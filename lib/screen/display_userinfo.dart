import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/login_bloc.dart';
import 'package:gazzabko_admin_app/model/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  final String job;

  const ProfileScreen({Key key, this.user, this.job = "non"}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginBloc _bloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Siddhibinaya Admin App",
          style: GoogleFonts.playfairDisplay(color: Colors.black, fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.remove_from_queue,
                color: Colors.black54,
              ),
              onPressed: () {
                print("Logout");
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              })
        ],
      ),
      body: Container(
          margin: EdgeInsets.only(top: 10),
          child: ListView(
            children: <Widget>[
              Center(
                child: Container(
                    height: 200,
                    width: 200,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 5),
                              blurRadius: 10)
                        ],
                        image: DecorationImage(
                            image: AssetImage("assets/img/profile.jpg"),
                            fit: BoxFit.cover))),
              ),
              Center(
                child: Text("${widget.user.name}",
                    style: GoogleFonts.playfairDisplay(fontSize: 30)),
              ),
              Center(
                child: Text("${widget.user.email}",
                    style: GoogleFonts.quicksand(fontSize: 15)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("${widget.user.accType}", style: GoogleFonts.oswald()),
                  Container(
                    margin: EdgeInsets.only(left: 5, right: 5, top: 10),
                    width: 3,
                    height: 20,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                          Colors.black,
                          Colors.white,
                        ])),
                  ),
                  Text("${widget.user.area}", style: GoogleFonts.oswald()),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff15A881),
                        Color(0xFF77CD07),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(2, 5),
                          blurRadius: 10)
                    ],
                    borderRadius: BorderRadius.circular(5)),
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      "Today's Attendance",
                      style: GoogleFonts.quicksand(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                    StreamBuilder<String>(
                        stream: _bloc.getAttendanceStatus(widget.user.email),
                        builder: (context, snapshot) {
                          return Builder(builder: (context) {
                            return Switch(
                              value: snapshot.hasError ? false : true,
                              onChanged: (value) {
                                if (value != false) {
                                  _bloc
                                      .setAttendanceStatus(widget.user.email)
                                      .whenComplete(() {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text("Attendance Set")));
                                  });
                                }
                              },
                              activeColor: snapshot.data == "leave"
                                  ? Color(0xffFF0000)
                                  : Color(0xffF5FF73),
                            );
                          });
                        })
                  ],
                ),
              ),
              Container(
                child: Material(),
              )
            ],
          )),
    );
  }
}
