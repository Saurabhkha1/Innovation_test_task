// import 'dart:io';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:test_innoventure/authentication/firebase/firebase_service.dart';
// import 'package:test_innoventure/feature/home/presentation/bloc/home_cubit.dart';
// import 'package:test_innoventure/feature/login/presentation/bloc/login_cubit.dart';
// import 'package:test_innoventure/feature/login/presentation/pages/login_page.dart';
// import 'package:test_innoventure/main.dart'; // Import your main.dart file.

// // Mock FirebaseCore for testing purposes.
// class MockFirebaseCore extends Mock implements FirebaseService {}

// void main() {
//   group('Firebase Initialization', () {
//     late MockFirebaseCore mockFirebaseService;
//     setUp(() {
//       mockFirebaseService = MockFirebaseCore();
//       // Stub FirebaseService.initializeApp() to return a FirebaseApp instance.
//       when(mockFirebaseService.initializeApp(options: anyNamed('options')))
//           .thenAnswer((_) async => Firebase.app());
//     });
//     testWidgets('Initializes Firebase for non-web and specific platforms',
//         (WidgetTester tester) async {
//       // Create a mock instance of FirebaseCore.
//       final mockFirebaseCore = MockFirebaseCore();

//       // Stub the behavior of Firebase.initializeApp to return a FirebaseApp instance.
//       when(mockFirebaseCore.initializeApp())
//           .thenAnswer((_) async => Firebase.app());

//       // Mock dotenv.env for Firebase options.
//       final dotenvMock = {
//         'FIREBASE_API_KEY': 'your_api_key',
//         'FIREBASE_APP_ID': 'your_app_id',
//         'FIREBASE_MESSAGING_SENDER_ID': 'your_sender_id',
//         'FIREBASE_PROJECT_ID': 'your_project_id',
//       };

//       // Simulate loading dotenv.env.
//       when(dotenv.load(fileName: ".env")).thenAnswer((_) async => dotenvMock);

//       // Set up platform mocks (you can mock Platform.isIOS and Platform.isMacOS similarly).
//       kIsWeb = false;
//       Platform.isMacOS = true;
//       Platform.isMacOS = false;

//       // Ensure Firebase.initializeApp is called with the mocked FirebaseCore instance.
//       await Firebase.initializeApp();

//       // Verify Firebase.initializeApp was called with correct options.
//       verify(mockFirebaseCore.initializeApp()).called(1);
//     });
//   });

//   testWidgets('Loads environment variables from .env file',
//       (WidgetTester tester) async {
//     final dotenvMock = {
//       'FIREBASE_API_KEY': 'your_api_key',
//       'FIREBASE_APP_ID': 'your_app_id',
//       'FIREBASE_MESSAGING_SENDER_ID': 'your_sender_id',
//       'FIREBASE_PROJECT_ID': 'your_project_id',
//     };
//     when(dotenv.load(fileName: ".env")).thenAnswer((_) async => dotenvMock);

//     // Simulate loading dotenv.env.
//     main();

//     // Verify that the Firebase options are fetched correctly.
//     expect(dotenv.env['FIREBASE_API_KEY'], 'your_api_key');
//     expect(dotenv.env['FIREBASE_APP_ID'], 'your_app_id');
//     expect(dotenv.env['FIREBASE_MESSAGING_SENDER_ID'], 'your_sender_id');
//     expect(dotenv.env['FIREBASE_PROJECT_ID'], 'your_project_id');
//   });

//   testWidgets('Widgets binding and app initialization',
//       (WidgetTester tester) async {
//     // Ensure WidgetsFlutterBinding.ensureInitialized() is called.
//     WidgetsFlutterBinding.ensureInitialized();

//     // Mock dotenv.env for Firebase options.
//     final dotenvMock = {
//       'FIREBASE_API_KEY': 'your_api_key',
//       'FIREBASE_APP_ID': 'your_app_id',
//       'FIREBASE_MESSAGING_SENDER_ID': 'your_sender_id',
//       'FIREBASE_PROJECT_ID': 'your_project_id',
//     };
//     when(dotenv.load(fileName: ".env")).thenAnswer((_) async => dotenvMock);

//     // Create a mock instance of FirebaseCore.
//     final mockFirebaseCore = MockFirebaseCore();

//     // Stub the behavior of Firebase.initializeApp to return a FirebaseApp instance.
//     when(mockFirebaseCore.initializeApp())
//         .thenAnswer((_) async => Firebase.app());

//     // Run the app.
//     main();

//     // Verify that runApp() was called with MyApp.
//     expect(find.byType(MyApp), findsOneWidget);

//     // Verify that MaterialApp with LoginPage is rendered.
//     expect(find.byType(MaterialApp), findsOneWidget);
//     expect(find.byType(LoginPage), findsOneWidget);
//   });

//   testWidgets('Bloc initialization', (WidgetTester tester) async {
//     // Ensure WidgetsFlutterBinding.ensureInitialized() is called.
//     WidgetsFlutterBinding.ensureInitialized();

//     // Mock dotenv.env for Firebase options.
//     final dotenvMock = {
//       'FIREBASE_API_KEY': 'your_api_key',
//       'FIREBASE_APP_ID': 'your_app_id',
//       'FIREBASE_MESSAGING_SENDER_ID': 'your_sender_id',
//       'FIREBASE_PROJECT_ID': 'your_project_id',
//     };
//     when(dotenv.load(fileName: ".env")).thenAnswer((_) async => dotenvMock);

//     // Create a mock instance of FirebaseCore.
//     final mockFirebaseCore = MockFirebaseCore();

//     // Stub the behavior of Firebase.initializeApp to return a FirebaseApp instance.
//     when(mockFirebaseCore.initializeApp())
//         .thenAnswer((_) async => Firebase.app());

//     // Run the app.
//     main();

//     // Verify LoginCubit and HomeCubit are initialized.
//     expect(find.byType(LoginCubit), findsOneWidget);
//     expect(find.byType(HomeCubit), findsOneWidget);
//   });

//   testWidgets('Error handling with FirebaseCrashlytics',
//       (WidgetTester tester) async {
//     // Ensure WidgetsFlutterBinding.ensureInitialized() is called.
//     WidgetsFlutterBinding.ensureInitialized();

//     // Mock dotenv.env for Firebase options.
//     final dotenvMock = {
//       'FIREBASE_API_KEY': 'your_api_key',
//       'FIREBASE_APP_ID': 'your_app_id',
//       'FIREBASE_MESSAGING_SENDER_ID': 'your_sender_id',
//       'FIREBASE_PROJECT_ID': 'your_project_id',
//     };
//     when(dotenv.load(fileName: ".env")).thenAnswer((_) async => dotenvMock);

//     // Create a mock instance of FirebaseCore.
//     final mockFirebaseCore = MockFirebaseCore();

//     // Stub the behavior of Firebase.initializeApp to return a FirebaseApp instance.
//     when(mockFirebaseCore.initializeApp())
//         .thenAnswer((_) async => Firebase.app());

//     // Run the app.
//     main();

//     // Simulate a Flutter error and verify FirebaseCrashlytics records it.
//     final error = FlutterErrorDetails(exception: Exception('Test error'));
//     FirebaseCrashlytics.instance.recordFlutterError(error);

//     // Verify that FirebaseCrashlytics.recordFlutterError was called with the error.
//     verify(FirebaseCrashlytics.instance.recordFlutterError(error)).called(1);
//   });
// }
