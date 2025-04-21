import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:offline_first_approach/features/todo/domain/models/todo_model.dart';
part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<TodoModel>()])

class HiveAdapters {}