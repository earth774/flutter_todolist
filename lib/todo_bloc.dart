import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skooldio_flutter_1/todo_event.dart';
import 'package:skooldio_flutter_1/todo_item.dart';
import 'package:skooldio_flutter_1/todo_provider.dart';
import 'package:skooldio_flutter_1/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoProvider todoProvider = TodoProvider.instace;

  TodoBloc() : super(initialTodoState()) {
    List<TodoItem> todos = [];
    on<AddTodoEvent>((event, emit) async {
      await todoProvider.insertTodo(TodoItem(
          id: event.id, title: event.title, notes: event.notes, done: false));
    });

    on<UpdateTodoEvent>((event, emit) async {
      await todoProvider.updateTodo(event.item);
    });

    on<DeleteTodoEvent>((event, emit) async {
      await todoProvider.deleteTodo(event.item);
    });

    on<FetchTodoEvent>((event, emit) async {
      todos = await todoProvider.fetchTodos();
      emit(TodoListState(todos: todos));
    });
  }
}
