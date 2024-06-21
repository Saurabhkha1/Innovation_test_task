import 'package:test_innoventure/feature/home/domain/entities/home_comment_model.dart';

abstract class HomeRepository {
  Future<List<HomeCommentModel>> fetchItems();
}
