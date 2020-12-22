import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/screens/todo_screen.dart';

class HomeScreen extends StatelessWidget {
  TodoController _todoController = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Todo List'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(TodoScreen());
        },
      ),
      body: Container(
          child: Obx(() => ListView.separated(
                itemBuilder: (context, index) => Dismissible(
                  key: UniqueKey(),
                  onDismissed: (_) {
                    var removed = _todoController.todos[index];
                    _todoController.todos.removeAt(index);
                    Get.snackbar('Task Removed',
                        'The task ${removed.text} was removed successfully',
                        mainButton: FlatButton(
                          child: Text('Undo'),
                          onPressed: () {
                            if (removed.isNull) {
                              return;
                            }
                            _todoController.todos.insert(index, removed);
                            if (Get.isSnackbarOpen) {
                              Get.back();
                            }
                          },
                        ));
                  },
                  child: ListTile(
                    title: Text(
                      _todoController.todos[index].text,
                      style: _todoController.todos[index].done
                          ? TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough)
                          : TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1.color),
                    ),
                    onTap: () {
                      Get.to(TodoScreen(
                        index: index,
                      ));
                    },
                    leading: Checkbox(
                      value: _todoController.todos[index].done,
                      onChanged: (value) {
                        var todo = _todoController.todos[index];
                        todo.done = value;
                        _todoController.todos[index] = todo;
                      },
                    ),
                    trailing: Icon(Icons.chevron_right),
                  ),
                ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: _todoController.todos.length,
              ))),
    );
  }
}
