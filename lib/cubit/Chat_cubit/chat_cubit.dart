import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:chat_app/Models/message.dart';
import 'package:chat_app/constant_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  static String RoomsCollection = KmessagesCollection;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(RoomsCollection);
  List<Message> messagesList = [];
  void sendMessage({required String message, required String email}) {
    try {
      messages.add({
        Kmessages: message,
        KcreatedAt: DateTime.now(),
        Kid: email,
      });
    } catch (e) {}
  }

  void getMessages() {
    messages.orderBy(KcreatedAt, descending: true).snapshots().listen((event) {
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages: messagesList));
    });
  }
}
