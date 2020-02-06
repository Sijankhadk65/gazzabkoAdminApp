import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/login_bloc.dart';
import 'package:gazzabko_admin_app/screen/login_screen.dart';
import 'package:gazzabko_admin_app/screen/profile_screen.dart';
import 'package:provider/provider.dart';

import 'model/user.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  LoginBloc _bloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _bloc.currentUserStateStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Select lot');
            case ConnectionState.waiting:
              return CircularProgressIndicator();
            case ConnectionState.active:
              return Provider(
                child: snapshot.hasData
                    ? StreamBuilder<User>(
                        stream: _bloc.currentUserData(snapshot.data),
                        builder: (context, usersnapshot) {
                          if (usersnapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          switch (usersnapshot.connectionState) {
                            case ConnectionState.none:
                              return Text('Select lot');
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            case ConnectionState.active:
                              return usersnapshot.data.accType == "admin"
                                  // ? HomeScreen(
                                  //     user: usersnapshot.data,
                                  //   )
                                  ? ProfileScreen(
                                      user: usersnapshot.data,
                                    )
                                  : Scaffold(
                                      appBar: AppBar(),
                                      body: Column(
                                        children: <Widget>[
                                          Text("UnAuthorizedAccess"),
                                          IconButton(
                                              icon: Icon(Icons.power),
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                              })
                                        ],
                                      ),
                                    );
                            default:
                              return Container();
                          }
                        })
                    : LoginScreen(),
                create: (context) => _bloc,
                dispose: (context, LoginBloc bloc) => bloc.dispose(),
              );

            default:
              return Container();
          }
        },
      ),
    );
  }
}
