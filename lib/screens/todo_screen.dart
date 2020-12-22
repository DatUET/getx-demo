import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoScreen extends StatelessWidget {
  TodoController _todoController = Get.find<TodoController>();
  TextEditingController _textEditingController = TextEditingController();

  final int index;

  TodoScreen({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (!index.isNull) {
      text = _todoController.todos[index].text;
      _textEditingController.text = text;
    }

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
                child: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                  hintText: 'What do you want to accomplish?',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none),
              style: TextStyle(
                fontSize: 25.0,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 9,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  child: Text('Cancel'),
                  color: Colors.red,
                  onPressed: () {
                    Get.back();
                  },
                ),
                RaisedButton(
                  child: Text(index.isNull ? 'Add' : 'Edit'),
                  color: Colors.green,
                  onPressed: () {
                    if (_textEditingController.text.isNotEmpty) {
                      if (index.isNull) {
                        _todoController.todos.add(Todo(
                            text: _textEditingController.text, done: false));
                      } else {
                        var todo = _todoController.todos[index];
                        todo.text = _textEditingController.text;
                        _todoController.todos[index] = todo;
                      }
                      Get.back();
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
