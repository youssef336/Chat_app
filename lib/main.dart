import 'package:chat_app/bloc_Observer.dart';
import 'package:chat_app/cubit/Chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubit/login%20cubit/login_cubit.dart';
import 'package:chat_app/cubit/register_cubit/register_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/pages/Login_page.dart';
import 'package:chat_app/pages/Register_page.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (context) => ChatCubit(),
        ),
      ],
      child: MaterialApp(
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegesterPage.id: (context) => RegesterPage(),
          ChatPage.id: (context) => ChatPage()
        },
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.id,
      ),
    );
  }
}
