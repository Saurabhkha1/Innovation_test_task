// lib/core/utils/password_validator.dart
class PasswordValidator {
  static bool isValid(String password) {
    final RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$',
    );
    return passwordRegExp.hasMatch(password);
  }
}
