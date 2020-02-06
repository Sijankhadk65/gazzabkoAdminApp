import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider {
  final _firebaseAuthInstance = FirebaseAuth.instance;

  Stream<FirebaseUser> get onAuthStateChanged =>
      _firebaseAuthInstance.onAuthStateChanged;

  Future<AuthResult> createUser(String email, String password) {
    return _firebaseAuthInstance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<AuthResult> login(String email, String password) {
    return _firebaseAuthInstance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
