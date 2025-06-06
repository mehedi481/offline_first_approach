import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:offline_first_approach/features/todo/domain/models/todo_model.dart';
import 'package:offline_first_approach/features/todo/presentation/providers/todo_providers.dart';

class CreateTodoScreen extends ConsumerStatefulWidget {
  const CreateTodoScreen({super.key});

  @override
  ConsumerState<CreateTodoScreen> createState() => _CreateTodoScreenState();
}

class _CreateTodoScreenState extends ConsumerState<CreateTodoScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Todo')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add the new todo to the provider or database
                final newTodo = TodoModel(
                  title: titleController.text,
                  description: descriptionController.text,
                  isCompleted: false,
                  isSynced: false,
                );
                ref.read(todoNotifierProvider.notifier).addTodo(newTodo);
                Navigator.pop(context); // Go back to the previous screen
              },
              child: const Text('Create Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
