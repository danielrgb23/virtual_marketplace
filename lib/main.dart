import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:virtual_marketplace/themes/theme.dart';
import 'package:virtual_marketplace/firebase_options.dart';
import 'package:virtual_marketplace/service/auth_service.dart';
import 'package:virtual_marketplace/screens/base/base_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  runApp(const MyApp());

  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  // firestore.collection('teste').add({'teste': 'teste'});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AuthService(),
      child: MaterialApp(
        title: 'Loja de roupas',
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: BaseScreen(),
      ),
    );
  }
}
