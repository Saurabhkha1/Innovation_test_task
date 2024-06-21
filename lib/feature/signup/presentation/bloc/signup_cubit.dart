// sign_up_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_innoventure/feature/signup/presentation/bloc/signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseAuth _firebaseAuth;

  SignUpCubit(this._firebaseAuth) : super(SignUpInitial());

  Future<void> signUp(String email, String password) async {
    emit(SignUpLoading());
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignUpSuccess(userCredential.user!.uid));
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
