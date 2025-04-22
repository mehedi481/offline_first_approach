import 'package:hive_ce_flutter/hive_flutter.dart';
import '../../domain/models/todo_model.dart';

class LocalDataSource {
  final Box<TodoModel> box;

  LocalDataSource(this.box);

  List<TodoModel> getTodos() => box.values.toList();

  TodoModel? getTodoById(String id) => box.get(id);

  Future<void> addTodo(TodoModel todo) async {
    await box.put(todo.id, todo);
  }

  Future<void> updateTodo(TodoModel todo) async {
    await box.put(todo.id, todo);
  }

  Future<void> deleteTodo(String id) async {
    await box.delete(id);
  }
}