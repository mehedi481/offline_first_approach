import 'package:dio/dio.dart';
import '../../domain/models/todo_model.dart';

class RemoteDataSource {
  final Dio dio;

  RemoteDataSource(this.dio);

  Future<void> syncTodo(TodoModel todo) async {
    await dio.post('https://jsonplaceholder.typicode.com/posts', data: todo.toJson());
  }

  Future<void> updateTodo(TodoModel todo) async {
    await dio.put('https://jsonplaceholder.typicode.com/posts/${todo.id}', data: todo.toJson());
  }

  Future<void> deleteTodo(String id) async {
    await dio.delete('https://jsonplaceholder.typicode.com/posts/$id');
  }
}