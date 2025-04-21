// TodoModel
class TodoModel {
  String? id;
  String? title;
  String? description;
  bool? isCompleted;
  bool? isSynced;

  TodoModel({this.id, this.title, this.description, this.isCompleted});

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isCompleted = json['isCompleted'];
    isSynced = json['isSynced'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['isCompleted'] = isCompleted;
    data['isSynced'] = isSynced;
    return data;
  }
}
