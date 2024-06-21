import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:test_innoventure/authentication/network/analytics_interceptor.dart';

class ApiService {
  final Dio _dio;
  final FirebaseAnalytics _analytics;

  ApiService(this._dio, this._analytics) {
    _dio.interceptors.add(AnalyticsInterceptor(_analytics));
  }

  Future<Response> fetchItem() async {
    try {
      return _dio.get('https://jsonplaceholder.typicode.com/comments');
    } catch (e) {
      throw Exception(e);
    }
  }
}
