import 'package:flutter/material.dart';
import 'package:virtual_marketplace/themes/theme_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(hintText: "E-mail"),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (email) {
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                // controller: ,
                decoration: const InputDecoration(hintText: "Senha"),
                autocorrect: false,
                obscureText: true,
                validator: (senha) {
                  if (senha!.isEmpty || senha.length < 6)
                    return "Senha inválida";
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
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
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
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
    );
  }
}
