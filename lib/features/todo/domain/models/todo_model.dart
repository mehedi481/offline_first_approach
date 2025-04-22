// TodoModel
import 'package:freezed_annotation/freezed_annotation.dart';
part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@JsonSerializable()
@freezed
class TodoModel with _$TodoModel {
  String? id;
  String? title;
  String? description;
  bool? isCompleted;
  bool? isSynced;

  TodoModel({
    this.id,
    this.title,
    this.description,
    this.isCompleted,
    this.isSynced,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);
}
