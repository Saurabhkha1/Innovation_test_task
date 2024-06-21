// item_state.dart
import 'package:equatable/equatable.dart';
import 'package:test_innoventure/feature/home/domain/entities/home_comment_model.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoggedOut extends HomeState {}

class HomeLoaded extends HomeState {
  final List<HomeCommentModel> items;

  HomeLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class HomeError extends HomeState {
  final String error;

  HomeError(this.error);

  @override
  List<Object> get props => [error];
}
