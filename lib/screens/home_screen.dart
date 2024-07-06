import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_8/controller/todo_controller.dart';
import 'package:flutter_application_8/main.dart';
import 'package:flutter_application_8/models/todo.dart';
import 'package:flutter_application_8/repository/todo_repository.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//import 'package:awesome_dialog/awesome_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoad = false;
  @override
  Widget build(BuildContext context) {
    // dependency injection
    var todoController = TodoController(TodoRepository());
    todoController.fetchTodoList();
    GlobalKey<ScaffoldState> scaffKey = GlobalKey();
    return Scaffold(
      // FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.limeAccent,
          onPressed: () {
            Todo newAdd = Todo(
                userId: 3, title: 'This New Add khaled n', completed: false);
            todoController.postTodo(newAdd);
          }),
      key: scaffKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.limeAccent[100],
        title: Text('Rest API'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshotz) {
          //
          if (snapshotz.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.orange[100],
              ),
            );
          }
          //
          if (snapshotz.hasError) {
            return Center(
              child: Text('Error'),
            );
          }
          return SafeArea(
            child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 4),
                itemBuilder: (context, index) {
                  var todoz = snapshotz.data?[index];
                  return Slidable(
                    startActionPane:
                        ActionPane(motion: StretchMotion(), children: [
                      SlidableAction(
                          spacing: 6,
                          label: 'patch',
                          icon: Icons.edit,
                          backgroundColor: Colors.blueAccent,
                          onPressed: (context) => {
                                todoController
                                    .updatePatchCompleted(todoz!)
                                    .then((value) {
                                  print(value);
                                  final _context = MyApp.navKey.currentContext;
                                  if (_context != null) {
                                    ScaffoldMessenger.of(_context)
                                        .showSnackBar(SnackBar(
                                      content: Text("The Parched Successfully"),
                                    ));
                                  }
                                }),
                              }),
                    ]),
                    endActionPane: ActionPane(
                        extentRatio: 0.6,
                        motion: StretchMotion(),
                        children: [
                          SlidableAction(
                              label: 'edit',
                              icon: Icons.edit,
                              backgroundColor: Colors.greenAccent,
                              onPressed: (context) => {
                                    todoController.updatePutCompeleted(todoz!),
                                  }),
                          SizedBox(
                            width: 4,
                          ),
                          SlidableAction(
                              label: 'delete',
                              icon: Icons.delete_forever,
                              backgroundColor: Colors.redAccent,
                              onPressed: (context) => {
                                    todoController
                                        .deleteTodoList(todoz!)
                                        .then((value) {
                                      print(value);
                                      final _context =
                                          MyApp.navKey.currentContext;
                                      if (_context != null) {
                                        ScaffoldMessenger.of(_context)
                                            .showSnackBar(SnackBar(
                                          content:
                                              Text("The Deleted Successfully"),
                                        ));
                                      }
                                    }),
                                    //  AwesomeDialog(context: context)
                                  }),
                        ]),
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  spreadRadius: 1,
                                  blurRadius: 12)
                            ]),
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: Colors.limeAccent,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(16),
                                          bottomLeft: Radius.circular(16))),
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  child: Center(child: Text('${todoz?.id}')),
                                )),
                            Expanded(
                                flex: 3,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AutoSizeText(
                                          '${todoz?.title}',
                                          textAlign: TextAlign.left,
                                          minFontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        )),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 0.0,
                    height: 5.0,
                  );
                },
                itemCount: snapshotz.data?.length ?? 0),
          );
        },
      ),
    );
  }
}
