import 'dart:convert';

class TodoModel {
  final int? id;
  final DateTime createdAt;
  final String todo;
  final String userId;
  final bool isDone;
  final int priority;

  TodoModel({
    this.id,
    required this.createdAt,
    required this.todo,
    required this.userId,
    required this.isDone,
    required this.priority,
  });

  TodoModel copyWith({
    int? id,
    DateTime? createdAt,
    String? todo,
    String? userId,
    bool? isDone,
    int? priority,
  }) {
    return TodoModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      todo: todo ?? this.todo,
      userId: userId ?? this.userId,
      isDone: isDone ?? this.isDone,
      priority: priority ?? this.priority,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'todo': todo,
      'isDone': isDone,
      'priority': priority,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id']?.toInt(),
      createdAt: DateTime.now(),
      todo: map['todo'] ?? '',
      userId: map['userId'] ?? '',
      isDone: map['isDone'] ?? false,
      priority: map['priority']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source));
}
