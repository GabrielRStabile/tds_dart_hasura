import '../models/todo_model.dart';

abstract class ICreateTodoData {
  Future<TodoModel> create(TodoModel todo);
}
