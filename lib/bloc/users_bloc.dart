import 'dart:async';
import 'dart:io';

import 'package:gazzabko_admin_app/data/repository.dart';
import 'package:gazzabko_admin_app/model/user.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _repo = Repository();
  List<String> areaslist = [];

  final _usersSubject = BehaviorSubject<List<User>>();
  Function(List<User>) get changeUser => _usersSubject.sink.add;
  Stream<List<User>> get user => _usersSubject.stream;

  final _nameSubject = BehaviorSubject<String>();
  Function(String) get changeName => _nameSubject.sink.add;
  Stream<String> get name => _nameSubject.stream.transform(
          StreamTransformer.fromHandlers(handleData: (String name, sink) {
        if (name != "") {
          sink.add(name);
        } else {
          sink.addError("Empty!");
        }
      }));

  final _emailSubject = BehaviorSubject<String>();
  Function(String) get changeEmail => _emailSubject.sink.add;
  Stream<String> get email => _emailSubject.stream.transform(
          StreamTransformer.fromHandlers(handleData: (String email, sink) {
        if (email != "" &&
            email.contains("@") &&
            email.contains(".com") &&
            !email.contains(" ") &&
            (email.contains("gmail") ||
                email.contains("outlook") ||
                email.contains("icloud"))) {
          sink.add(email);
        } else {
          sink.addError("Empty!");
        }
      }));

  final _passwordSubject = BehaviorSubject<String>();
  Function(String) get changePassword => _passwordSubject.sink.add;
  Stream<String> get password => _passwordSubject.stream;

  final _accTypeSubject = BehaviorSubject<String>();
  Function(String) get changeAccType => _accTypeSubject.sink.add;
  Stream<String> get accType => _accTypeSubject.stream;

  final _selectedAreaSubject = BehaviorSubject<String>();
  Function(String) get changeArea => _selectedAreaSubject.sink.add;
  Stream<String> get area => _selectedAreaSubject.stream;

  Future<void> saveUser(File image, String adminEmail) {
    Map<String, dynamic> user = {
      "email": _emailSubject.value,
      "name": _nameSubject.value,
      "accType": _accTypeSubject.value == null ? "RSM" : _accTypeSubject.value,
      "area": _selectedAreaSubject.value,
      "admin": "$adminEmail",
      "password": _passwordSubject.value,
      "photoUrl": ""
    };
    return _repo.saveUser(parseJsonToUser(user));
  }

  Future<void> updateUser(String adminEmail) {
    Map<String, dynamic> user = {
      "email": _emailSubject.value,
      "name": _nameSubject.value,
      "accType": _accTypeSubject.value == null ? "RSM" : _accTypeSubject.value,
      "area": _selectedAreaSubject.value,
      "admin": "$adminEmail",
      "password": _passwordSubject.value,
      "photoUrl": ""
    };
    return _repo.updateUser(_emailSubject.value, user);
  }

  Stream<bool> get submitValid =>
      Observable.combineLatest2(email, name, (String email, String name) {
        return true;
      });

  UserBloc() {
    getUsers();
    getAreas();
  }

  getUsers() {
    _repo.getUsers().listen((users) {
      changeUser(users);
    });
  }

  getAreas() {
    _repo.getAreas().listen((areas) {
      areaslist = areas;
      changeArea(areaslist.first);
    });
  }

  void dispose() {
    _usersSubject.close();
    _nameSubject.close();
    _emailSubject.close();
    _accTypeSubject.close();
    _passwordSubject.close();
    _selectedAreaSubject.close();
  }
}
