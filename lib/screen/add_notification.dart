import 'package:flutter/material.dart';
import 'package:gazzabko_admin_app/bloc/notification_bloc.dart';
import 'package:gazzabko_admin_app/model/notification.dart';
import 'package:gazzabko_admin_app/widget/input_fields.dart';
import 'package:provider/provider.dart';

class AddNotification extends StatefulWidget {
  final String job, adminEmail;
  final AppNotifications notifications;
  const AddNotification(
      {Key key, this.job, this.adminEmail, this.notifications})
      : super(key: key);
  @override
  _AddNotificationState createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
  TextEditingController _titleController, _bodyController;
  NotificationBloc _bloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = Provider.of<NotificationBloc>(context);
  }

  @override
  void initState() {
    _titleController = TextEditingController();
    _bodyController = TextEditingController();
    super.initState();
    updateControllers();
  }

  updateControllers() {
    if (widget.job == "update") {
      _titleController.text = widget.notifications.title;
      _bodyController.text = widget.notifications.body;
    }
  }

  updateSubjects() {
    if (widget.job == "update") {
      _bloc.changeTitle(widget.notifications.title);
      _bloc.changeBody(widget.notifications.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    updateSubjects();
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        child: ListView(
          children: <Widget>[
            StreamBuilder<String>(
              stream: _bloc.title,
              builder: (context, snapshot) {
                return InputFields(
                  controller: _titleController,
                  errorText: snapshot.error,
                  hintText: "Today the office will be closed.",
                  label: "Title",
                  onChanged: _bloc.changeTitle,
                );
              },
            ),
            StreamBuilder<String>(
              stream: _bloc.body,
              builder: (context, snapshot) {
                return InputFields(
                  controller: _bodyController,
                  maxLinesCount: 20,
                  errorText: snapshot.error,
                  hintText:
                      "The reason for the office being closed is............",
                  label: "Body",
                  onChanged: _bloc.changeBody,
                );
              },
            ),
            Builder(builder: (context) {
              return StreamBuilder(
                stream: _bloc.submitValid,
                builder: (context, snapshot) {
                  return RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 2.0,
                    color: Theme.of(context).appBarTheme.color,
                    disabledColor: Color(0xfFA46D40),
                    onPressed: snapshot.data == true
                        ? widget.job == "update"
                            ? () {
                                _bloc
                                    .updateNotification(
                                        widget.notifications.seen.asList(),
                                        widget.notifications.sentDate)
                                    .whenComplete(() {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Notification Updated!"),
                                  ));
                                });
                              }
                            : () {
                                _bloc.saveNotification().whenComplete(() {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Notification Added!"),
                                  ));
                                });
                              }
                        : null,
                    child: Text(
                      widget.job == "update" ? "Update" : "Send",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
