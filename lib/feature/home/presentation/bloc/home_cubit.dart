import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_innoventure/authentication/network/api_service.dart';
import 'package:test_innoventure/core/data/network/network_service.dart';
import 'package:test_innoventure/feature/home/data/data_source/home_remote_data_source.dart';
import 'package:test_innoventure/feature/home/data/repositories/home_repository_impl.dart';
import 'package:test_innoventure/feature/home/domain/use_case/home_item_use_case.dart';
import 'package:test_innoventure/feature/home/presentation/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeItemsUseCase fetchItemsUseCase;

  HomeCubit()
      : fetchItemsUseCase = _createFetchItemsUseCase(),
        super(HomeInitial());

  static HomeItemsUseCase _createFetchItemsUseCase() {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    final dio = Dio();
    final apiService = ApiService(dio, analytics);
    final repository =
        HomeRepositoryImpl(HomeRemoteDataSource(NetworkService(), apiService));
    return HomeItemsUseCase(repository);
  }

  Future<void> fetchItems() async {
    emit(HomeLoading());
    try {
      final items = await fetchItemsUseCase.call();
      emit(HomeLoaded(items));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(HomeLoading());
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signOut();
      emit(HomeLoggedOut());
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
