import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/notification_bloc.dart';
import 'package:gazzabko_admin_app/model/notification.dart';
import 'package:gazzabko_admin_app/screen/add_notification.dart';
import 'package:gazzabko_admin_app/widget/empty_list_message.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  final String adminEmail;

  const NotificationScreen({Key key, this.adminEmail}) : super(key: key);
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<NotificationBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: Container(
        child: StreamBuilder<List<AppNotifications>>(
          stream: _bloc.notifications,
          builder: (context, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error);
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("Awaiting Bids.....");
                break;
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.active:
                return snapshot.data.isNotEmpty
                    ? ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(snapshot.data[index].title),
                            onDismissed: (direction) {
                              _bloc
                                  .deleteNotification(
                                      snapshot.data[index].sentDate)
                                  .whenComplete(() {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Notification Deleted!")));
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.only(
                                    top: 5, left: 10, right: 10, bottom: 5),
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(5),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => Provider(
                                                    create: (_) =>
                                                        NotificationBloc(),
                                                    child: AddNotification(
                                                      job: "update",
                                                      notifications:
                                                          snapshot.data[index],
                                                    ),
                                                  )));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: ListTile(
                                          title: Text(
                                            snapshot.data[index].title,
                                            style: GoogleFonts.playfairDisplay(
                                                fontSize: 25),
                                          ),
                                          dense: true,
                                          subtitle: Text(
                                            snapshot.data[index].body.length >
                                                    120
                                                ? snapshot.data[index].body
                                                        .substring(0, 100) +
                                                    "......."
                                                : snapshot.data[index].body,
                                            style: GoogleFonts.quicksand(
                                              fontSize: 15,
                                            ),
                                          )),
                                    ),
                                  ),
                                )),
                          );
                        },
                      )
                    : EmptyListMessage(
                        message: "No notifications till now !",
                      );
                break;
              default:
                return null;
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => Provider(
                        create: (_) => NotificationBloc(),
                        dispose: (context, NotificationBloc bloc) =>
                            bloc.dispose(),
                        child: AddNotification(),
                      )));
        },
        child: Icon(Icons.add_circle),
      ),
    );
  }
}
