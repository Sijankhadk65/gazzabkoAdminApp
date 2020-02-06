import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/login_bloc.dart';
import 'package:gazzabko_admin_app/bloc/notification_bloc.dart';
import 'package:gazzabko_admin_app/bloc/sales_bloc.dart';
import 'package:gazzabko_admin_app/bloc/shops_bloc.dart';
import 'package:gazzabko_admin_app/bloc/target_bloc.dart';
import 'package:gazzabko_admin_app/bloc/users_bloc.dart';
import 'package:gazzabko_admin_app/model/user.dart';
import 'package:gazzabko_admin_app/screen/notification_screen.dart';
import 'package:gazzabko_admin_app/screen/sales_screen.dart';
import 'package:gazzabko_admin_app/screen/shops_screen.dart';
import 'package:gazzabko_admin_app/screen/target_screen.dart';
import 'package:gazzabko_admin_app/screen/users_screen.dart';
import 'package:gazzabko_admin_app/widget/drawer_items.dart';
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 300,
            ),
            DrawerItem(
              icon: Icons.supervised_user_circle,
              color: Color(0Xff1B4F7F),
              title: "Users",
              subtitle: "Manage your user's info here.",
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Provider(
                              child: UsersScreen(
                                adminEmail: widget.user.email,
                              ),
                              create: (_) => UserBloc(),
                            )));
              },
            ),
            DrawerItem(
              icon: Icons.notifications_active,
              color: Colors.yellow,
              title: "Notifications",
              subtitle: "Manage your messages to users here.",
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Provider(
                              child: NotificationScreen(),
                              create: (_) => NotificationBloc(),
                            )));
              },
            ),
            DrawerItem(
              icon: Icons.shopping_cart,
              color: Colors.green,
              title: "Sales",
              subtitle: "Get sales info of all area here.",
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Provider(
                              child: SalesScreen(
                                user: widget.user,
                              ),
                              create: (_) => SalesBloc(),
                            )));
              },
            ),
            DrawerItem(
              icon: Icons.shop_two,
              color: Colors.indigo,
              title: "Shops",
              subtitle: "Information regarding shops cna be found here.",
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Provider(
                              child: ShopsScreen(),
                              create: (_) => ShopsBloc(),
                            )));
              },
            ),
            DrawerItem(
              icon: Icons.format_list_numbered,
              color: Colors.indigo,
              title: "Targets",
              subtitle: "Monthly targets information can be found here.",
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Provider(
                              child: TargetScreen(),
                              create: (_) => TargetBloc(),
                            )));
              },
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
              child: RawMaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 5.0,
                fillColor: Colors.white,
                child: Text(
                  "Logout",
                  style: TextStyle(
                      fontFamily: "Montserrat", fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ),
          ],
        ),
      ),
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
