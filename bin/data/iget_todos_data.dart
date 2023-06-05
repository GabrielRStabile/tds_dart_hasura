import '../models/todo_model.dart';

abstract class IGetTodosData {
  Future<List<TodoModel>> getTodos(String userId);
}
