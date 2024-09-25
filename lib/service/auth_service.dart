import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtual_marketplace/models/user.dart';
import 'package:virtual_marketplace/helpers/firebase_errors.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> signIn(
      {required UserData user, required Function onSucess,required Function onError}) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
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
    return null;
  }

  Future<String?> cadastrarUsuario({
    required String email,
    required String senha,
    required String nome,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      await userCredential.user!.updateDisplayName(nome);

      print("Funcionou! Tamo aqui no bgl!");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "O e-mal já está em uso.";
      }
      return e.code;
    }

    return null;
  }
}
