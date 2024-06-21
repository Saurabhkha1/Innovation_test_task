import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  static Future<FirebaseApp> initializeApp(
      {String? name, FirebaseOptions? options}) {
    return Firebase.initializeApp(name: name, options: options);
  }
}
