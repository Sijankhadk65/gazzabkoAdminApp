import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gazzabko_admin_app/data/repository.dart';
import 'package:gazzabko_admin_app/model/user.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc {
  final _repo = Repository();
  String _email;
  String _password;
  User user;
  String _code;

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
          sink.addError("Invalid email type");
        }
      }));

  final _passwordSubject = BehaviorSubject<String>();
  Function(String) get changePassword => _passwordSubject.sink.add;
  Stream<String> get password => _passwordSubject.stream.transform(
          StreamTransformer.fromHandlers(handleData: (String password, sink) {
        if (password.isNotEmpty) {
          sink.add(password);
        } else {
          sink.addError("Don't leave this empty");
        }
      }));

  Stream<bool> submitValidtor() => Observable.combineLatest2(email, password,
          (String email, String password) {
        _email = email;
        _password = password;
        return true;
      });

  Stream<String> get currentUserStateStream => _repo.onAuthStateChanged;
  LoginBloc();

  login() {
    _repo.login(_email, _password).then((value) {
      if (value.user.email == _email) {}
    });
  }

  Stream<FirebaseUser> get getCurrentUser => _repo.getCurrentUser;
  Stream<User> currentUserData(email) => _repo.getUser(email);

  saveTokenDocument(String token, String userEmail) {
    _repo.saveTokenDocument({
      "token": token,
      "createdAt": FieldValue.serverTimestamp(),
      "platform": Platform.operatingSystem
    }, userEmail);
  }

  Stream<String> getAttendanceStatus(email) {
    _code =
        "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}";
    print(_code);
    return _repo.getTodaysAttendance(email, _code);
  }

  Future<void> setAttendanceStatus(email) {
    _code =
        "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}";
    print(_code);
    return _repo.setAttendance(email, _code);
  }

  void dispose() {
    _emailSubject.close();
    _passwordSubject.close();
  }
}
