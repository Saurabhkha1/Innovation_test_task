import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AuthCubit extends Cubit<User?> {
  final FirebaseAuth firebaseAuth;
  StreamSubscription<User?>? _authSubscription;

  AuthCubit(this.firebaseAuth) : super(firebaseAuth.currentUser) {
    _authSubscription = firebaseAuth.authStateChanges().listen((user) {
      if (!isClosed) {
        emit(user);
      }
    });
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
