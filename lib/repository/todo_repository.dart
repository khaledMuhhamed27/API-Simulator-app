import 'dart:convert';
import 'package:flutter_application_8/models/todo.dart';
import 'package:flutter_application_8/repository/repository.dart';
import 'package:http/http.dart' as http;

class TodoRepository implements Repository {
  // pleaceholder Link
  String myDataURL = "https://jsonplaceholder.typicode.com";
  // delete
  @override
  Future<String> deleteCompeleted(Todo todo) async {
    var url = Uri.parse('$myDataURL/todos/${todo.id}');
    var result = 'false';
    await http.delete(url).then((value) {
      print(value.body);
      // ignore: unused_local_variable
      var StaTus = value.statusCode;

      return result = 'true';
    });
    return result;
  }

  @override
  Future<List<Todo>> getTodoList() async {
    // TODO: implement getTodoList
    // https://jsonplaceholder.typicode.com/photos
    List<Todo> myTodoList = [];
    var url = Uri.parse('$myDataURL/todos');
    var respose = await http.get(url);
    print('status code ${respose.statusCode}');
    var body = jsonDecode(respose.body);
    // parse
    for (var i = 0; i < body.length; i++) {
      myTodoList.add(Todo.fromJson(body[i]));
    }
    return myTodoList;
  }

  // patch example
  @override
  Future<String> patchCompeleted(Todo todo) async {
    var url = Uri.parse('$myDataURL/todos/${todo.id}');
    // call back data
    String resData = '';
    await http.patch(
      url,
      body: {
        'completed': (!todo.completed!).toString(),
      },
      headers: {'Authorization': 'your_token'},
    ).then((response) {
      // homeScreen -> data
      Map<String, dynamic> result = jsonDecode(response.body);
      print(result);
      resData = result['completed'];
    });
    return resData;
  }

// modify passed variable only and treat variables null or default
  @override
  Future<String> putCompeleted(Todo todo) async {
    var url = Uri.parse('$myDataURL/todos/${todo.id}');
    // call back data
    String resData = '';
    await http.put(
      url,
      body: {
        'completed': (!todo.completed!).toString(),
      },
      headers: {'Authorization': 'your_token'},
    ).then((response) {
      // homeScreen -> data
      Map<String, dynamic> result = jsonDecode(response.body);
      print(result);
      resData = result['completed'];
    });
    return resData;
  }

  @override
  Future<String> postCompeleted(Todo todo) async {
    print('${todo.toJson()}');
    var url = Uri.parse('$myDataURL/todos/');
    var response = await http.post(url, body: todo.toJson());
    print('Status Code = ${response.statusCode}');
    print(response.body);
    return 'true';
  }
}
