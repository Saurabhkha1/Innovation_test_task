// domain/use_cases/fetch_items_use_case.dart

import 'package:test_innoventure/feature/home/domain/entities/home_comment_model.dart';
import 'package:test_innoventure/feature/home/domain/repositories/home_repository.dart';

class HomeItemsUseCase {
  final HomeRepository repository;

  HomeItemsUseCase(this.repository);

  Future<List<HomeCommentModel>> call() async {
    return repository.fetchItems();
  }
}
