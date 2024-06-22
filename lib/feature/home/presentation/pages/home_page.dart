import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_innoventure/feature/auth/presentation/bloc/auth_cubit.dart';
import 'package:test_innoventure/feature/auth/presentation/bloc/auth_state.dart';
import 'package:test_innoventure/feature/detail_view/presentation/pages/detail_page.dart';
import 'package:test_innoventure/feature/home/presentation/bloc/home_cubit.dart';
import 'package:test_innoventure/feature/home/presentation/bloc/home_state.dart';
import 'package:test_innoventure/feature/login/presentation/bloc/login_cubit.dart';
import 'package:test_innoventure/feature/login/presentation/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchItems(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home',style: TextStyle(color: Colors.white),),
          centerTitle: true,
          elevation: 2,
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
              onPressed: () async {
                AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
                authCubit.logout();
              },
              icon: const Icon(Icons.logout,color: Colors.white,),
            ),
          ],
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthUnauthenticated) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (route) => false,
              );
            }
          },
          child: BlocListener<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeLogout) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) =>
                          LoginCubit(firebaseAuth: FirebaseAuth.instance),
                      child: LoginPage(),
                    ),
                  ),
                );
              }
            },
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeLoaded) {
                  return ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: const Color.fromRGBO(255, 255, 255, 1.0),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.name.toString()),
                                  Text(item.email ?? "")
                                ],
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios_outlined,color: Colors.blue,),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(item: item),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is HomeError) {
                  return Center(child: Text(state.error));
                } else if (state is HomeLogout) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(child: Text('No items'));
              },
            ),
          ),
        ),
      ),
    );
  }
}
