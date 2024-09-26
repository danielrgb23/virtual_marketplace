import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtual_marketplace/models/user.dart';
import 'package:virtual_marketplace/helpers/firebase_errors.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? user;

  bool _loading = false;
  bool get loading => _loading;

  Future<String?> signIn(
      {required UserData user,
      required Function onSuccess,
      required Function onError}) async {
    _loading = true;
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: user.email!, password: user.password!);

      onSuccess() {}
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return "Usuário não cadastrado";
        case "wrong-password":
          return "Email ou senha incorretos";
      }
      onError(getErrorString(e.code));
      _loading = false;
      return e.code;
    }
    return null;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    final User currentUser = _firebaseAuth.currentUser!;
    if (currentUser != null) {
      user = currentUser;
    }
    notifyListeners();
  }
}
