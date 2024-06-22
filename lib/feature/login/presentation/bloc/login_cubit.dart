import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_innoventure/core/data/network/network_service.dart';
import 'package:test_innoventure/feature/login/presentation/bloc/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth firebaseAuth;
  final NetworkService _networkService = NetworkService();

  LoginCubit({required this.firebaseAuth}) : super(LoginInitial());

  Future<void> checkSession() async {
    emit(LoginLoading());
    bool isConnected = await _networkService.isConnected();
    if (!isConnected) {
      emit(const LoginError(message: 'No Internet'));
      return;
    }
    try {
      final user = firebaseAuth.currentUser;
      if (user != null) {
        emit(LoginAuth(user: user));
      } else {
        emit(LoginInitial());
      }
    } catch (e) {
      emit(LoginError(message: 'Error: ${e.toString()}'));
    }
  }

  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());
      bool isConnected = await _networkService.isConnected();
      if (!isConnected) {
        emit(const LoginError(message: 'No Internet'));
        return;
      }
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        emit(LoginSuccess());
      } else {
        emit(const LoginError(message: 'User is null'));
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        emit(LoginError(message: 'Firebase Auth Error: ${e.message}'));
      } else {
        emit(LoginError(message: 'Error: ${e.toString()}'));
      }
    }
  }
}
