import 'package:test_innoventure/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:test_innoventure/feature/home/domain/entities/home_comment_model.dart';
import 'package:test_innoventure/feature/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource dataSource;

  HomeRepositoryImpl(this.dataSource);

  @override
  Future<List<HomeCommentModel>> fetchItems() async {
    final items = await dataSource.fetchItems();
    return items
        .map((e) => HomeCommentModel(
            id: e.id,
            email: e.email,
            name: e.name,
            postId: e.postId,
            body: e.body))
        .toList();
  }
}
