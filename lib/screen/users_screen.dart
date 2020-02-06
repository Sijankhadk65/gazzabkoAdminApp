import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/users_bloc.dart';
import 'package:gazzabko_admin_app/model/user.dart';
import 'package:gazzabko_admin_app/screen/add_user.dart';
import 'package:gazzabko_admin_app/widget/profile_card.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  final String adminEmail;

  const UsersScreen({Key key, @required this.adminEmail}) : super(key: key);
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  UserBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: Container(
        child: StreamBuilder<List<User>>(
          stream: _bloc.user,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text('Select lot');
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.active:
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ProfileCard(
                      user: snapshot.data.elementAt(index),
                      amdinEmail: widget.adminEmail,
                    );
                  },
                );
              default:
                return null;
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Provider(
                        create: (_) => UserBloc(),
                        dispose: (context, UserBloc bloc) => bloc.dispose(),
                        child: AddUser(job: "new"),
                      )));
        },
      ),
    );
  }
}
