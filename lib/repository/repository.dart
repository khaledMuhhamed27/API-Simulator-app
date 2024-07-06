// fake server (Placeholder JSON)

import 'package:flutter_application_8/models/todo.dart';

abstract class Repository {
  // GET
  Future<List<Todo>> getTodoList();
  // PATCH
  Future<String> patchCompeleted(Todo _todo);
  // POST
  Future<String> postCompeleted(Todo _todo);
  // UPDATE
  Future<String> putCompeleted(Todo _todo);
  // DELETE
  Future<String> deleteCompeleted(Todo _todo);
}
