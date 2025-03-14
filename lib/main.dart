import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/Login_page.dart';
import 'package:chat_app/pages/Register_page.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Chat_app());
}

// ignore: camel_case_types
class Chat_app extends StatelessWidget {
  const Chat_app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => const LoginPage(),
        RegesterPage.id: (context) => const RegesterPage(),
        ChatPage.id: (context) => ChatPage()
      },
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.id,
    );
  }
}
