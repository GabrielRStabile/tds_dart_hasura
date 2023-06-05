class TodoModel {
  int id;
  DateTime createdAt;
  String todo;
  String userId;
  bool isDone;
  int priority;

  TodoModel({
    required this.id,
    required this.createdAt,
    required this.todo,
    required this.userId,
    required this.isDone,
    required this.priority,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as int,
      priority: json['priority'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
      isDone: json['isDone'] as bool,
      userId: json['userId'] as String? ?? '',
      todo: json['todo'] as String,
    );
  }

  TodoModel.copyFrom(TodoModel todoModel)
      : id = todoModel.id,
        priority = todoModel.priority,
        createdAt = todoModel.createdAt,
        isDone = todoModel.isDone,
        userId = todoModel.userId,
        todo = todoModel.todo;
}
