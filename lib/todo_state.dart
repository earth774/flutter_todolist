// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:skooldio_flutter_1/todo_item.dart';

abstract class TodoState {
  TodoState();
}

class initialTodoState extends TodoState {}

class TodoListState extends TodoState {
  List<TodoItem> todos;

  TodoListState({
    required this.todos,
  });
}
