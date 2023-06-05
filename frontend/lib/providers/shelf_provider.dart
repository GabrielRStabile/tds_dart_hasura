import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/todo_model.dart';

class ShelfProvider {
  Dio api = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:5400',
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  Future<List<TodoModel>> getTodos(String userId) async {
    Response response = await api.get(
      '/todo',
      queryParameters: {
        'userId': userId,
      },
    );

    if (response.statusCode == 200) {
      List<TodoModel> todos = [];
      jsonDecode(response.data as String).forEach((e) {
        todos.add(TodoModel.fromJson(e as Map<String, dynamic>));
      });
      return todos;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<TodoModel> addTodo(
    String userId,
    String todo,
    int priority,
    bool isDone,
  ) async {
    Response response = await api.post(
      '/todo',
      data: {
        'todo': todo,
        'priority': priority,
        'isDone': isDone,
        'userId': userId,
      },
    );

    if (response.statusCode == 200) {
      return TodoModel.fromJson(
        jsonDecode(response.data as String) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to add todo');
    }
  }

  Future<TodoModel> editTodo(
    int id,
    String todo,
    int priority,
    bool isDone,
  ) async {
    Response response = await api.put(
      '/todo',
      data: {
        'id': id,
        'todo': todo,
        'priority': priority,
        'isDone': isDone,
      },
    );

    if (response.statusCode == 200) {
      return TodoModel.fromJson(
        jsonDecode(response.data as String) as Map<String, dynamic>,
      );
    } else {
      throw Exception('Failed to edit todo');
    }
  }

  Future<void> deleteTodo(
    int id,
  ) async {
    Response response = await api.delete(
      '/todo',
      queryParameters: {
        'id': id,
      },
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete todo');
    }
  }
}
