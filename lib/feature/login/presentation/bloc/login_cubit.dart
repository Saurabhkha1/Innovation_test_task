import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_innoventure/core/data/network/network_service.dart';
import 'package:test_innoventure/feature/login/presentation/bloc/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  FirebaseAuth? firebaseAuth;
  NetworkService? _networkService;

  Future<void> checkSession() async {
    emit(LoginLoading());
    try {
      final user = firebaseAuth!.currentUser;
      if (user != null) {
        emit(LoginAuth(user: user));
      }
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());
      bool? isConnected = await _networkService?.isConnected();
      if (isConnected!) {
        emit(const LoginError(message: 'No Internet'));
      }
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
