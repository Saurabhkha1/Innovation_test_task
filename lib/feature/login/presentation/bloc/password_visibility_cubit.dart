import 'package:bloc/bloc.dart';

class PasswordVisibilityCubit extends Cubit<bool> {
  PasswordVisibilityCubit() : super(true);

  void toggleVisibility() => emit(!state);
}
