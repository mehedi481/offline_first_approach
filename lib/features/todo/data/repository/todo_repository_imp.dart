import 'package:offline_first_approach/features/todo/data/repository/todo_repository.dart';
import '../../domain/models/todo_model.dart';
import '../datasources/local_datasource.dart';
import '../datasources/remote_datasource.dart';

class TodoRepositoryImpl implements ITodoRepository {
  final LocalDataSource local;
  final RemoteDataSource remote;

  TodoRepositoryImpl(this.local, this.remote);

  @override
  List<TodoModel> getTodos() => local.getTodos();

  @override
  TodoModel? getTodoById(String id) => local.getTodoById(id);

  @override
  Future<void> addTodo(TodoModel todo) async {
    await local.addTodo(todo);
    try {
      await remote.syncTodo(todo);
      await local.updateTodo(todo.copyWith(isSynced: true));
    } catch (_) {}
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await local.updateTodo(todo);
    try {
      await remote.updateTodo(todo);
      await local.updateTodo(todo.copyWith(isSynced: true));
    } catch (_) {}
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todo = local.getTodoById(id);
    await local.deleteTodo(id);
    if (todo != null) {
      try {
        await remote.deleteTodo(id);
      } catch (_) {}
    }
  }

  @override
  Future<void> syncPendingTodos() async {
    final unsynced = local.getTodos().where((e) => !e.isSynced!);
    for (final todo in unsynced) {
      print('Syncing todo: ${todo.title}'); // Debug print
      try {
        // await remote.syncTodo(todo);
        // await local.updateTodo(todo.copyWith(isSynced: true));
      } catch (_) {}
    }
  }
}
