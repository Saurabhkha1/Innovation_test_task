// lib/feature/login/domain/usecases/validate_email.dart
import 'package:test_innoventure/core/utils/email_validator.dart';

class ValidateEmail {
  bool call(String email) {
    return EmailValidator.isValid(email);
  }
}
