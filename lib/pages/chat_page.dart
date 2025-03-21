import 'package:chat_app/Models/message.dart';
import 'package:chat_app/constant_file.dart';
import 'package:chat_app/cubit/Chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/ChatBuble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  bool isLoading = false;

  final _controller = ScrollController();

  TextEditingController controller = TextEditingController();

  String email = FirebaseAuth.instance.currentUser!.email.toString();
  ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    // Initialize with a default value or fetch the actual email

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Klogo,
              height: 66,
            ),
            const Text(
              "Chat",
              style: TextStyle(color: (KWhiteColor)),
            ),
          ],
        ),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                var messagesList =
                    BlocProvider.of<ChatCubit>(context).messagesList;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBuble(
                            message: messagesList[index],
                          )
                        : ChatBubleForFreind(message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                BlocProvider.of<ChatCubit>(context).sendMessage(
                  message: value,
                  email: email,
                );
                controller.clear();
                _controller.animateTo(0,
                    duration: const Duration(microseconds: 500),
                    curve: Curves.fastOutSlowIn);
              },
              decoration: InputDecoration(
                hintText: 'Typing....',
                labelText: "Send Message",
                suffixIcon: const Icon(
                  Icons.send,
                  color: kPrimaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
