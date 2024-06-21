import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_innoventure/core/widget/custom_button.dart';
import 'package:test_innoventure/feature/detail_view/presentation/pages/detail_page.dart';
import 'package:test_innoventure/feature/home/presentation/bloc/home_cubit.dart';
import 'package:test_innoventure/feature/home/presentation/bloc/home_state.dart';
import 'package:test_innoventure/feature/login/presentation/bloc/login_cubit.dart';
import 'package:test_innoventure/feature/login/presentation/pages/login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  HomeCubit homeCubit = HomeCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchItems(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: [
            IconButton(
              onPressed: () {
                // context.read<HomeCubit>().logout();
                homeCubit.logout();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocListener<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeLogout) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => LoginCubit(),
                      child: LoginPage(),
                    ),
                  ),
                );
              });
            }
          },
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is HomeLoaded) {
                return Stack(alignment: Alignment.bottomCenter, children: [
                  ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: index % 2 == 0
                              ? Colors.white
                              : Colors.grey.withOpacity(0.16),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Id: ${item.id.toString()}"),
                                  Text("Name: ${item.name ?? ""}")
                                ],
                              ),
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
                  ),
                  Positioned(
                      child: CustomButton(
                    onPressed: () {
                      context.read<HomeCubit>().logout();
                    },
                    buttonText: 'Logout',
                  ))
                ]);
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
    );
  }
}
