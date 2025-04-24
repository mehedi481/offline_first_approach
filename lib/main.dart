import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:offline_first_approach/core/constants.dart';
import 'package:offline_first_approach/core/hive/hive_registrar.g.dart';
import 'package:offline_first_approach/core/hive/sync_manager.dart';
import 'package:offline_first_approach/features/todo/domain/models/todo_model.dart';
import 'package:offline_first_approach/features/todo/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapters();
  await Hive.openBox<TodoModel>(AppConstants.todoListBox);

  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Start monitoring connectivity for syncing
    ref.read(syncManagerProvider).startMonitoring(ref);

    return MaterialApp(
      title: 'Offline First Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
