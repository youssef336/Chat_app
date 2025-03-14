import 'package:chat_app/Models/message.dart';
import 'package:chat_app/constant_file.dart';
import 'package:chat_app/widgets/ChatBuble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  bool isLoading = false;

  final _controller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(KmessagesCollection);
  TextEditingController controller = TextEditingController();

  ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(KcreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          isLoading = false;
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            child: Scaffold(
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
                    child: ListView.builder(
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        messages.add({
                          Kmessages: value,
                          KcreatedAt: DateTime.now(),
                          Kid: email,
                        });
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
            ),
          );
        } else {
          isLoading = true;
          return Image.asset(
            Klogo,
            height: 66,
          );
        }
      },
    );
  }
}
