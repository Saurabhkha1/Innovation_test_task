import 'package:dio/dio.dart';
import 'package:test_innoventure/authentication/network/api_service.dart';
import 'package:test_innoventure/core/data/network/network_service.dart';
import 'package:test_innoventure/feature/home/data/model/comment_model.dart';

class HomeRemoteDataSource {
  HomeRemoteDataSource(this.networkService, this.apiService);
  final NetworkService networkService;
  final dio = Dio();
  final ApiService apiService;

  Future<List<CommentModel>> fetchItems() async {
    apiService.fetchItem();
    bool isConnected = await networkService.isConnected();

    if (!isConnected) {
      throw Exception('No internet connection');
    }
    try {
      final response = await apiService.fetchItem();
      if (response.statusCode == 200) {
        final List<dynamic> json = response.data;
        return json.map((e) => CommentModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to fetch items');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
