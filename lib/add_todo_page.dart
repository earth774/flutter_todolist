import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skooldio_flutter_1/todo_bloc.dart';
import 'package:skooldio_flutter_1/todo_event.dart';
import 'package:skooldio_flutter_1/todo_item.dart';
import 'package:skooldio_flutter_1/todo_provider.dart';
import 'package:skooldio_flutter_1/todo_state.dart';
import 'package:uuid/uuid.dart';

class AddTodoPage extends StatefulWidget {
  AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add todo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Title",
              ),
            ),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                return ElevatedButton(
                    onPressed: () async {
                      context.read<TodoBloc>().add(AddTodoEvent(
                          id: Uuid().v4(),
                          title: _titleController.text,
                          notes: _notesController.text));
                      context.read<TodoBloc>().add(FetchTodoEvent());
                      if (!mounted) return;
                      closePage(context);
                    },
                    child: const Text("Add "));
              },
            ),
          ]),
        ),
      ),
    );
  }

  void closePage(BuildContext context) {
    Navigator.of(context).pop();
  }
}
