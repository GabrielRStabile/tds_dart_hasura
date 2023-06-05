import 'package:hasura_connect/hasura_connect.dart';

import '../data/icreate_todo_data.dart';
import '../data/idelete_todo_data.dart';
import '../data/iget_todos_data.dart';
import '../data/iupdate_todo_data.dart';
import '../models/todo_model.dart';

class HasuraRepository
    implements
        IGetTodosData,
        ICreateTodoData,
        IDeleteTodoData,
        IUpdateTodoData {
  HasuraConnect hasuraConnect = HasuraConnect(
    'https://famous-swine-77.hasura.app/v1/graphql',
    headers: {
      'content-type': 'application/json',
      'x-hasura-admin-secret':
          '74ZhCcJBTiArJyGW4kSQsxQ2zyob571OloRwUGo4v2LIyfnIKOVsZS5g4v2mUcL9',
    },
  );

  @override
  Future<List<TodoModel>> getTodos(String userId) async {
    final Map<String, dynamic> response = await hasuraConnect.query(
      '''
      query {
        todos(where: {userId: {_eq: "$userId"}}) {
          id
          isDone
          priority
          todo
        }
      }
    ''',
    );

    return (response['data']['todos'] as List)
        .map<TodoModel>((e) => TodoModel.fromMap(e))
        .toList();
  }

  @override
  Future<TodoModel> create(TodoModel todo) async {
    final response = await hasuraConnect.mutation(
      r'''
    mutation($is_done: Boolean, $priority: smallint, $todo: String, $user: String, $created_at: timestamp) {
      insert_todos_one(object: {isDone: $is_done, priority: $priority, todo: $todo, userId: $user, createdAt: $created_at}) {
          createdAt
          id
          isDone
          priority
          todo
          userId
          }
    }
  ''',
      variables: {
        'is_done': todo.isDone,
        'priority': todo.priority,
        'todo': todo.todo,
        'user': todo.userId,
        'created_at': todo.createdAt.toIso8601String(),
      },
    );

    return TodoModel.fromMap(response['data']['insert_todos_one']);
  }

  @override
  Future<void> delete(String id) async {
    await hasuraConnect.mutation(
      r'''
    mutation DeleteTodo($id: Int) {
      delete_todos(where: {id: {_eq: $id}}) {
        returning {
          id
        }
      }
    }
  ''',
      variables: {
        'id': int.parse(id),
      },
    );
  }

  @override
  Future<TodoModel> update(TodoModel todo) async {
    final response = await hasuraConnect.mutation(
      r'''
    mutation EditTodo($_eq: Int, $is_done: Boolean, $priority: smallint, $todo: String) {
      update_todos(_set: {todo: $todo, priority: $priority, isDone: $is_done}, where: {id: {_eq: $_eq}}) {
        returning {
          createdAt
          id
          isDone
          priority
          todo
        }
      }
    }
  ''',
      variables: {
        '_eq': todo.id,
        'is_done': todo.isDone,
        'priority': todo.priority,
        'todo': todo.todo,
      },
    );

    return TodoModel.fromMap(response['data']['update_todos']['returning'][0]);
  }
}
