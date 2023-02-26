// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:skooldio_flutter_1/todo_item.dart';

abstract class TodoEvent {
  TodoEvent();
}

class AddTodoEvent extends TodoEvent {
  String? id;
  String? title;
  String? notes;

  AddTodoEvent({
    this.id,
    this.title,
    this.notes,
  });
}

class UpdateTodoEvent extends TodoEvent {
  TodoItem item;

  UpdateTodoEvent({
    required this.item,
  });
}

class DeleteTodoEvent extends TodoEvent {
  TodoItem item;
  DeleteTodoEvent({
    required this.item,
  });
}

class FetchTodoEvent extends TodoEvent {
  FetchTodoEvent();
}
