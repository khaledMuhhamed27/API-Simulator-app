import 'package:flutter_application_8/models/todo.dart';
import 'package:flutter_application_8/repository/repository.dart';

class TodoController {
  final Repository _repository;
  TodoController(this._repository);

  // get
  Future<List<Todo>> fetchTodoList() async {
    return _repository.getTodoList();
  }

  // patch
  Future<String> updatePatchCompleted(Todo todo) async {
    return _repository.patchCompeleted(todo);
  }

  // put
  Future<String> updatePutCompeleted(Todo todo) async {
    return _repository.putCompeleted(todo);
  }

  // delete
  Future<String> deleteTodoList(Todo todo) async {
    return _repository.deleteCompeleted(todo);
  }

  // post
  Future<String> postTodo(Todo todo) async {
    return _repository.postCompeleted(todo);
  }
}
