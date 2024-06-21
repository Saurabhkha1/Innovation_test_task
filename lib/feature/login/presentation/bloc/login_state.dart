import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginAuth extends LoginState {
  final User? user;
  const LoginAuth({this.user});

  @override
  List<Object> get props => [];
}

class LoginUnAuth extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String message;
  const LoginError({required this.message});
  @override
  List<Object> get props => [];
}
