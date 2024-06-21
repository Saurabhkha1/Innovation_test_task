import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_innoventure/feature/detail_view/presentation/pages/detail_page.dart';
import 'package:test_innoventure/feature/home/presentation/bloc/home_cubit.dart';
import 'package:test_innoventure/feature/home/presentation/bloc/home_state.dart';
import 'package:test_innoventure/feature/login/presentation/pages/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                context.read<HomeCubit>().logout();
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Id: ${item.postId.toString()}"),
                        Text("Name: ${item.name ?? ""}")
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(item: item),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.error));
            } else if (state is HomeLoggedOut) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }
            return const Center(child: Text('No items'));
          },
        ),
      ),
    );
  }
}
