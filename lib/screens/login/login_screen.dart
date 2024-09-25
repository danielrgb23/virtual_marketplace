import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:virtual_marketplace/models/user.dart';
import 'package:virtual_marketplace/helpers/validators.dart';
import 'package:virtual_marketplace/service/auth_service.dart';
import 'package:virtual_marketplace/helpers/show_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(hintText: "E-mail"),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email) {
                    if (!emailValid(email!)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: passController,
                  decoration: const InputDecoration(hintText: "Senha"),
                  autocorrect: false,
                  obscureText: true,
                  validator: (senha) {
                    if (senha!.isEmpty || senha.length < 6) {
                      return "Senha inválida";
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                    ),
                    onPressed: () {},
                    child: const Text("Esqueci minha senha"),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context
                            .read<AuthService>()
                            .signIn(
                                onSucess: () {
                                  //TODO: FECHAR TELA DE LOGIN
                                },
                                onError: (e) {},
                                user: UserData(
                                    email: emailController.text,
                                    password: passController.text))
                            .then((String? error) {
                          showSnackBar(context: context, mensagem: error!);
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStateColor.resolveWith(
                        (states) => const Color.fromARGB(255, 4, 125, 141),
                      ),
                    ),
                    child: const Text(
                      "Entrar",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
