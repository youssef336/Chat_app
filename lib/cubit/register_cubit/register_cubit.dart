import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:chat_app/helper/custom_Snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> RegisterUser(
      {required String emailAddress, required String password}) async {
    emit(RegisterLoading());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterError(error: "Weak password"));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterError(error: "Email already in use"));
      } else {
        emit(RegisterError(error: "${e.code}"));
      }
    } on Exception catch (e) {
      emit(RegisterError(error: "something went wrong"));
    }
  }
}
