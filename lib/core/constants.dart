class AppConstants {
  // singleton
  static final AppConstants _instance = AppConstants._internal();
  factory AppConstants() => _instance;
  AppConstants._internal();

  // Hive Box
  static const String todoListBox = 'todo_list_box';
}
