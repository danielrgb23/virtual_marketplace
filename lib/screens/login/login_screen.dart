import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_marketplace/models/user.dart';
import 'package:virtual_marketplace/helpers/validators.dart';
import 'package:virtual_marketplace/models/user_manager.dart';
import 'package:virtual_marketplace/helpers/show_snack_bar.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, UserManager userManager, Widget? child) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      controller: emailController,
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'E-mail'),
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
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      autocorrect: false,
                      obscureText: true,
                      validator: (senha) {
                        if (senha!.isEmpty || senha.length < 6) {
                          return "Senha inválida";
                        }
                        return null;
                      },
                    ),
                    child!,
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: userManager.loading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  userManager.signIn(
                                      user: UserData(
                                          email: emailController.text,
                                          password: passController.text),
                                      onError: (error) {
                                        showSnackBar(
                                            context: context, mensagem: error!);
                                      },
                                      onSuccess: () {
                                        // TODO: FECHAR TELA DE LOGIN
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
                    ),
                  ],
                );
              },
              child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Sua lógica de esqueci minha senha aqui
                    },
                    child: const Text('Esqueci minha senha'),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
