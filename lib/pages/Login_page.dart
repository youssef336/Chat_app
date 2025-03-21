// ignore_for_file: file_names, use_build_context_synchronously, non_constant_identifier_names

import 'package:chat_app/constant_file.dart';
import 'package:chat_app/cubit/Chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubit/login%20cubit/login_cubit.dart';
import 'package:chat_app/pages/Register_page.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widgets/TextFeild_widget.dart';
import 'package:chat_app/widgets/custom_Buttom.dart';
import 'package:chat_app/helper/custom_Snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatelessWidget {
  static String id = 'LoginPage';
  String? emailAddress;
  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id);
          isLoading = false;
        }
        if (state is LoginError) {
          if (state.error != null) {
            custom_Snackbar(
              context,
              state.error,
            );
            isLoading = false;
          } else {
            custom_Snackbar(
              context,
              'An unknown error occurred',
            );
          }
        }
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7),
            child: Form(
              key: formkey,
              child: ListView(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Image.asset(
                    Klogo,
                    height: 110,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Scolar Chat",
                        style: TextStyle(
                          fontSize: 32,
                          color: KWhiteColor,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          color: KWhiteColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormFeild_widget(
                    labelText: 'Email',
                    onChange: (p0) {
                      emailAddress = p0;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormFeild_widget(
                    labelText: 'Password',
                    obscureText: true,
                    onChange: (p0) {
                      password = p0;
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  custom_Buttom(
                    text: 'LOGIN',
                    onTAP: () async {
                      if (formkey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context).Login(
                            emailAddress: emailAddress!, password: password!);
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'don\'t have an acount?',
                        style: TextStyle(color: KWhiteColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RegesterPage.id);
                        },
                        child: const Text(
                          '  REGISTER',
                          style: TextStyle(color: Color(0xff6C8A9D)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Login() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress!, password: password!);
  }
}
