import 'dart:async';

import 'package:gazzabko_admin_app/data/repository.dart';
import 'package:gazzabko_admin_app/model/notification.dart';
import 'package:rxdart/rxdart.dart';

class NotificationBloc {
  final _repo = Repository();
  String newTitle;
  String newBody;
  final _notificationSubject = BehaviorSubject<List<AppNotifications>>();
  Function(List<AppNotifications>) get changeNotifications =>
      _notificationSubject.sink.add;
  Stream<List<AppNotifications>> get notifications =>
      _notificationSubject.stream;

  final _titleSubject = BehaviorSubject<String>();
  Function(String) get changeTitle => _titleSubject.sink.add;
  Stream<String> get title => _titleSubject.stream.transform(
          StreamTransformer.fromHandlers(handleData: (String title, sink) {
        if (title != "") {
          sink.add(title);
        } else {
          sink.addError("Don't leave empty");
        }
      }));

  final _bodySubject = BehaviorSubject<String>();
  Function(String) get changeBody => _bodySubject.sink.add;
  Stream<String> get body => _bodySubject.stream.transform(
          StreamTransformer.fromHandlers(handleData: (String body, sink) {
        if (body != "") {
          sink.add(body);
        } else {
          sink.addError("Empty");
        }
      }));

  Stream<bool> get submitValid =>
      Observable.combineLatest2(title, body, (String title, String body) {
        newTitle = title;
        newBody = body;
        return true;
      });

  Future<void> saveNotification() {
    Map<String, dynamic> notification = {
      "sentDate": DateTime.now().toIso8601String(),
      "title": _titleSubject.value,
      "body": _bodySubject.value,
      "seen": []
    };
    return _repo.saveNotifications(parseJsonToNotification(notification));
  }

  Future<void> updateNotification(List<String> seen, String sentDate) {
    Map<String, dynamic> notification = {
      "title": _titleSubject.value,
      "body": _bodySubject.value,
      "seen": seen,
      "sentDate": sentDate,
    };
    return _repo.updateNotifications(notification);
  }

  Future<void> deleteNotification(String sentDate) =>
      _repo.deleteNotifications(sentDate);

  NotificationBloc() {
    getNotifications();
  }

  getNotifications() {
    _repo.getAppNotifications().listen((notification) {
      changeNotifications(notification);
    });
  }

  void dispose() {
    _notificationSubject.close();
    _titleSubject.close();
    _bodySubject.close();
  }
}
