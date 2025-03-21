// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names, unused_local_variable

import 'package:chat_app/constant_file.dart';
import 'package:chat_app/cubit/Chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubit/register_cubit/register_cubit.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widgets/TextFeild_widget.dart';
import 'package:chat_app/widgets/custom_Buttom.dart';
import 'package:chat_app/helper/custom_Snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegesterPage extends StatelessWidget {
  static String id = 'RegisterPage';
  String? emailAddress;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();

          Navigator.pushNamed(context, ChatPage.id);
          isLoading = false;
        } else if (state is RegisterError) {
          custom_Snackbar(
            context,
            state.error,
          );
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Form(
                key: formKey,
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
                          "Register",
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
                      text: 'REGISTER',
                      onTAP: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context).RegisterUser(
                              emailAddress: '$emailAddress',
                              password: '$password');
                          ;
                        } else {}
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'already have an account?',
                          style: TextStyle(color: KWhiteColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            '  LOGIN',
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
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> RegisterUser() async {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress!,
      password: password!,
    );
  }
}
