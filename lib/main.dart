import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:test_innoventure/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:test_innoventure/feature/auth/presentation/bloc/auth_state.dart';
import 'package:test_innoventure/feature/home/presentation/pages/home_page.dart';
import 'package:test_innoventure/feature/login/presentation/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: dotenv.env['FIREBASE_API_KEY']!,
    appId: dotenv.env['FIREBASE_APP_ID']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
  );

  if (kIsWeb || Platform.isIOS || Platform.isMacOS) {
    await Firebase.initializeApp(options: firebaseOptions);
  } else {
    await Firebase.initializeApp(
      name: 'testinnovation',
      options: firebaseOptions,
    );
  }
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthCubit(FirebaseAuth.instance),
          ),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.blue,
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
                primaryColor: Colors.blue),
            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  return const HomePage();
                } else {
                  return LoginPage();
                }
              },
            )));
  }
}
