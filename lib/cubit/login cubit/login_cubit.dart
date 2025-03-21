import 'package:bloc/bloc.dart';
import 'package:chat_app/helper/custom_Snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> Login(
      {required String emailAddress, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginError(error: "No user found for that email."));
      } else if (e.code == 'wrong-password') {
        emit(LoginError(error: "Wrong password provided for that user."));
      } else {
        emit(LoginError(error: "${e.code}"));
      }
    } on Exception catch (e) {
      emit(LoginError(error: "something went wrong"));
    }
  }
}
