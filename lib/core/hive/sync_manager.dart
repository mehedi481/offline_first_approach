import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:offline_first_approach/core/constants.dart';
import 'package:offline_first_approach/features/todo/data/datasources/local_datasource.dart';
import 'package:offline_first_approach/features/todo/data/datasources/remote_datasource.dart';
import 'package:offline_first_approach/features/todo/data/repository/todo_repository_imp.dart';
import 'package:offline_first_approach/features/todo/domain/models/todo_model.dart';

class SyncManager {
  final Connectivity _connectivity = Connectivity();
  final TodoRepositoryImpl repository;

  SyncManager(this.repository);

  void startMonitoring(WidgetRef ref) {
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      for (var result in results) {
        print('Connectivity changed: $result'); // Debug print
        if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
          print('Internet connection detected. Starting sync...'); // Debug print
          _syncData();
        }
      }
    });
  }

  Future<void> _syncData() async {
    try {
      await repository.syncPendingTodos();
      print('All pending todos synced successfully.'); // Debug print
    } catch (e) {
      print('Error syncing todos: $e'); // Debug print
    }
  }
}

final syncManagerProvider = Provider<SyncManager>((ref) {
  final localDataSource = LocalDataSource(Hive.box<TodoModel>(AppConstants.todoListBox));
  final remoteDataSource = RemoteDataSource(Dio());
  final repository = TodoRepositoryImpl(localDataSource, remoteDataSource);
  return SyncManager(repository);
});