import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtual_marketplace/models/user.dart';
import 'package:virtual_marketplace/helpers/firebase_errors.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool loading = false;

  Future<String?> signIn(
      {required UserData user,
      required Function onSuccess,
      required Function onError}) async {
    setLoading(true);
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
      return e.code;
    }
    setLoading(false);
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }
}
