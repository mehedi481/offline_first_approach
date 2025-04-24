import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:offline_first_approach/features/todo/domain/models/todo_model.dart';
import 'package:offline_first_approach/core/constants.dart';

// StreamProvider to watch the list of todos
final todoListProvider = StreamProvider<List<TodoModel>>((ref) async* {
  final box = Hive.box<TodoModel>(AppConstants.todoListBox);
  yield box.values.toList(); // Initial state

  await for (final _ in box.watch()) {
    yield box.values.toList(); // Reactive updates
  }
});

// StateNotifier for managing todo operations
class TodoNotifier extends StateNotifier<List<TodoModel>> {
  TodoNotifier() : super(Hive.box<TodoModel>(AppConstants.todoListBox).values.toList());

  void addTodo(TodoModel todo) {
    final box = Hive.box<TodoModel>(AppConstants.todoListBox);
    box.add(todo);
    state = box.values.toList();
  }

  void updateTodo(int index, TodoModel updatedTodo) {
    final box = Hive.box<TodoModel>(AppConstants.todoListBox);
    box.putAt(index, updatedTodo);
    state = box.values.toList();
  }

  void deleteTodoAt(int index) {
    final box = Hive.box<TodoModel>(AppConstants.todoListBox);
    box.deleteAt(index);
    state = box.values.toList();
  }
}

final todoNotifierProvider = StateNotifierProvider<TodoNotifier, List<TodoModel>>((ref) {
  return TodoNotifier();
});