// sign_up_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_innoventure/core/widget/custom_button.dart';
import 'package:test_innoventure/core/widget/custom_textfield.dart';
import 'package:test_innoventure/feature/signup/presentation/bloc/signup_cubit.dart';
import 'package:test_innoventure/feature/signup/presentation/bloc/signup_state.dart';

class SignUpPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(FirebaseAuth.instance),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                textFieldController: emailController,
                hintText: 'User Email',
                prefixIcon: const Icon(Icons.person),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                textFieldController: passwordController,
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
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<SignUpCubit, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              'Sign up successful! User ID: ${state.userId}')),
                    );
                  } else if (state is SignUpFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.error}')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SignUpLoading) {
                    return const CircularProgressIndicator();
                  }
                  return CustomButton(
                    onPressed: () {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();
                      if (email.isNotEmpty && password.isNotEmpty) {
                        context.read<SignUpCubit>().signUp(email, password);
                      }
                    },
                    buttonText: 'Sign Up',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
