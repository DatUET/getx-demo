import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoController extends GetxController {
  var todos = List<Todo>().obs;

  @override
  void onInit() {
    super.onInit();
    List storedTodo = GetStorage().read<List>('todos');
    if (!storedTodo.isNull) {
      todos = storedTodo.map((e) => Todo.fromMap(e)).toList().obs;
    }
    ever(todos, (_) {
      GetStorage().write('todos', todos.toList());
    });
  }
}
