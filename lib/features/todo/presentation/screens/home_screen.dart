import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:offline_first_approach/features/todo/presentation/providers/todo_providers.dart';
import 'package:offline_first_approach/features/todo/presentation/screens/create_todo_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Replace with your actual provider for todos
    final todos = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: todos.when(
        data:
            (todoList) =>
                todoList.isEmpty
                    ? const Center(child: Text('No todos available'))
                    : ListView.builder(
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        final todo = todoList[index];
                        return ListTile(
                          title: Text(todo.title ?? ''),
                          subtitle: Text(todo.description ?? ''),
                          trailing: IconButton(
                            icon: Icon(
                              todo.isCompleted == true
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                            ),
                            onPressed: () {
                              // Handle toggle complete
                            },
                          ),
                          onTap: () {
                            // Navigate to EditTodoScreen
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete Todo'),
                                content: const Text('Are you sure you want to delete this todo?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      ref.read(todoNotifierProvider.notifier).deleteTodoAt(index);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Delete'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateTodoScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
