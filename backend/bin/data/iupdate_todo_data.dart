import '../models/todo_model.dart';

abstract class IUpdateTodoData {
  Future<TodoModel> update(TodoModel todo);
}
