import 'package:flutter/material.dart';
import 'package:test_innoventure/feature/home/domain/entities/home_comment_model.dart';

class DetailPage extends StatelessWidget {
  final HomeCommentModel item;

  const DetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Id: ${item.id}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Post Id: ${item.postId}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Name: ${item.name}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Email: ${item.email}'),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Description: ${item.body}')
                ]),
          ),
        ),
      ),
    );
  }
}
