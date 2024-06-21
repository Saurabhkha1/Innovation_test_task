import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_innoventure/core/widget/custom_button.dart';
import 'package:test_innoventure/core/widget/custom_textfield.dart';
import 'package:test_innoventure/feature/home/presentation/pages/home_page.dart';
import 'package:test_innoventure/feature/login/presentation/bloc/login_cubit.dart';
import 'package:test_innoventure/feature/login/presentation/bloc/login_state.dart';
import 'package:test_innoventure/feature/signup/presentation/pages/signup_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bool isObsure = true;
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Flutter Test'),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginAuth) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Login Successfully')));
          } else if (state is LoginError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Login Failed')));
          } else if (state is LoginSuccess) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
        },
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    textFieldController: _emailController,
                    hintText: 'User Email',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  CustomTextField(
                    textFieldController: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.remove_red_eye,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomButton(
                    onPressed: () {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      context.read<LoginCubit>().login(email, password);
                    },
                    buttonText: 'Login',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    buttonText: 'Sign Up',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CustomButton(
                    onPressed: () {
                      FirebaseCrashlytics.instance.crash();
                    },
                    buttonText: 'Crash',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
