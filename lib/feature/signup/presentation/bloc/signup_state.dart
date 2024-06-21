// sign_up_state.dart
import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String userId;

  SignUpSuccess(this.userId);

  @override
  List<Object> get props => [userId];
}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure(this.error);

  @override
  List<Object> get props => [error];
}
