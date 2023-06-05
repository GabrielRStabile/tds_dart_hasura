import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'models/todo_model.dart';
import 'repositories/hasura_repository.dart';

final _router = Router()
  ..get('/todo', _getHandle)
  ..post('/todo', _postHandle)
  ..put('/todo', _putHandle)
  ..delete('/todo', _deleteHandle);

Future<Response> _getHandle(Request req) async {
  final query = req.url.queryParameters;

  if (query['userId'] == null) {
    return Response.badRequest(body: '{"error": "userId is required"}');
  }

  final response = await HasuraRepository().getTodos(query['userId']!);

  return Response.ok(response.map((e) => e.toJson()).toList().toString());
}

Future<Response> _postHandle(Request req) async {
  var bodyString = await req.readAsString();

  final todo = TodoModel.fromJson(bodyString);

  final response = await HasuraRepository().create(todo);

  return Response.ok(response.toJson());
}

Future<Response> _deleteHandle(Request req) async {
  final query = req.url.queryParameters;

  if (query['id'] == null) {
    return Response.badRequest(body: '{"error": "id is required"}');
  }

  await HasuraRepository().delete(query['id']!);

  return Response.ok(null);
}

Future<Response> _putHandle(Request req) async {
  var bodyString = await req.readAsString();

  final todo = TodoModel.fromJson(bodyString);

  final response = await HasuraRepository().update(todo);

  return Response.ok(response.toJson());
}

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;

  final handler = Pipeline().addMiddleware(logRequests()).addHandler(_router);

  final port = int.parse(Platform.environment['PORT'] ?? '5400');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
