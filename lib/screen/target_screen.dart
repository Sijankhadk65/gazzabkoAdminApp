import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/target_bloc.dart';
import 'package:gazzabko_admin_app/model/target.dart';
import 'package:gazzabko_admin_app/screen/add_target.dart';
import 'package:gazzabko_admin_app/widget/empty_list_message.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TargetScreen extends StatefulWidget {
  @override
  _TargetScreenState createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  TargetBloc _bloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<TargetBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Targets")),
      body: StreamBuilder<List<Target>>(
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Select lot');
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            case ConnectionState.active:
              return snapshot.data.isEmpty
                  ? EmptyListMessage(message: "Sorry No targets yet!")
                  : ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(snapshot.data[index].createdAt),
                          onDismissed: (direction) {
                            _bloc
                                .deleteTarget(snapshot.data[index].createdAt)
                                .whenComplete(() {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text("Target Info Deleted!")));
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(15),
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(5),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => Provider(
                                          create: (_) => TargetBloc(),
                                          child: AddTarget(
                                            job: "update",
                                            target: snapshot.data[index],
                                          ),
                                        ),
                                      ));
                                },
                                title: Text(
                                  snapshot.data[index].target.toString(),
                                  style: GoogleFonts.quicksand(fontSize: 25),
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    Text(
                                      snapshot.data[index].area + ",",
                                      style: GoogleFonts.playfairDisplay(),
                                    ),
                                    Text(
                                      " set for ${snapshot.data[index].month}/${snapshot.data[index].year}",
                                      style: GoogleFonts.playfairDisplay(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
            default:
              return null;
          }
        },
        stream: _bloc.targets,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Provider(
                        create: (_) => TargetBloc(),
                        dispose: (context, TargetBloc bloc) => bloc.dispose(),
                        child: AddTarget(),
                      )));
        },
      ),
    );
  }
}
