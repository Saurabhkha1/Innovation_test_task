import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_innoventure/feature/login/presentation/bloc/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());

      // Sign in user with email and password
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Emit LoginSuccess or LoginError based on authentication result
      if (userCredential.user != null) {
        emit(LoginSuccess());
      } else {
        emit(const LoginError(message: 'User is null'));
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        emit(const LoginError(message: 'Data Not  Found'));
        throw Exception('Firebase Auth Errors: ${e.message}');
      } else {
        throw Exception("Generic Error: ${e.toString()}");
      }
    }
  }
}
