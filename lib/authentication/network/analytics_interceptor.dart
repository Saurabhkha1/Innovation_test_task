import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnalyticsInterceptor extends Interceptor {
  final FirebaseAnalytics analytics;
  AnalyticsInterceptor(this.analytics);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.extra['startTime'] = DateTime.now();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      options.headers['User-ID'] = user.uid;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final startTime = response.requestOptions.extra['startTime'] as DateTime;
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMilliseconds;
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? 'Unknown';

    await analytics.logEvent(
        name: 'login_event_response',
        parameters: {'duration': duration, 'user_id': userId});
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final startTime = err.requestOptions.extra['startTime'] as DateTime;
    final endTime = DateTime.now();
    final duration = endTime.difference(startTime).inMilliseconds;
    final user = FirebaseAuth.instance.currentUser;
    final userId = user?.uid ?? 'Unknown';

    await analytics.logEvent(
        name: 'login_event_error',
        parameters: {'duration': duration, 'user_id': userId});

    super.onError(err, handler);
  }
}
