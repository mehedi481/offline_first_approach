// lib/features/todo/domain/repositories/i_todo_repository.dart

import 'package:offline_first_approach/features/todo/domain/models/todo_model.dart';

abstract class ITodoRepository {
  List<TodoModel> getTodos();
  TodoModel? getTodoById(String id);
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
  Future<void> syncPendingTodos();
}