import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/login_bloc.dart';
import 'package:gazzabko_admin_app/root.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          iconTheme: IconThemeData(color: Colors.black26),
          appBarTheme: AppBarTheme(
              color: Colors.white,
              textTheme: TextTheme(
                  title: GoogleFonts.playfairDisplay(
                      color: Colors.black, fontSize: 25)),
              iconTheme: IconThemeData(color: Colors.black38)),
          tabBarTheme: TabBarTheme(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5), topLeft: Radius.circular(5)),
              ))),
      // routes: <String, WidgetBuilder>{"/home": (_) => HomeScreen()},
      home: Provider(
        create: (context) => LoginBloc(),
        dispose: (context, LoginBloc bloc) => bloc.dispose(),
        child: Root(),
      ),
    );
  }
}
