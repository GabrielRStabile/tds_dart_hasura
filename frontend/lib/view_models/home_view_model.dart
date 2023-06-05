import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/todo_model.dart';
import '../providers/shelf_provider.dart';

class HomeViewModel with ChangeNotifier {
  ShelfProvider helper = ShelfProvider();
  List<TodoModel>? mainTodos;

  Future<String> getTodos(String userId) async {
    try {
      final response = await helper.getTodos(userId);

      if (response.isEmpty) {
        return 'Query returned null';
      }
      mainTodos = response;
      notifyListeners();
      return 'Success';
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        mainTodos ??= [];
        notifyListeners();

        return 'Success';
      } else {
        return 'Error';
      }
    }
  }

  Future<String> addTodo(TodoModel todoModel) async {
    final response = await helper.addTodo(
      todoModel.userId,
      todoModel.todo,
      todoModel.priority,
      todoModel.isDone,
    );

    mainTodos ??= [];
    mainTodos!.add(response);
    notifyListeners();
    return 'Success';
  }

  Future<String> editTodo(TodoModel todoModel) async {
    final response = await helper.editTodo(
      todoModel.id,
      todoModel.todo,
      todoModel.priority,
      todoModel.isDone,
    );

    mainTodos ??= [];
    mainTodos![mainTodos!.indexWhere((element) => todoModel.id == element.id)] =
        response;
    notifyListeners();
    return 'Success';
  }

  Future<String> deleteTodo(TodoModel todoModel) async {
    final response = await helper.deleteTodo(
      todoModel.id,
    );

    mainTodos ??= [];
    mainTodos!.removeWhere((element) => todoModel.id == element.id);
    notifyListeners();
    return 'Success';
  }

  Future<bool> todoCardOnCheckedCallback(bool val, int todoIndex) async {
    TodoModel originalModel = mainTodos![todoIndex];
    TodoModel copy = TodoModel.copyFrom(originalModel);
    copy.isDone = val;
    try {
      String response = await editTodo(copy);
      if (response != 'Success') {
        return false;
      }
    } catch (e) {
      return false;
    }
    mainTodos![todoIndex] = copy;
    notifyListeners();
    return true;
  }
}
