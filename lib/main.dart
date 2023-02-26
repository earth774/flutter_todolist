import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skooldio_flutter_1/add_todo_page.dart';
import 'package:skooldio_flutter_1/todo_bloc.dart';
import 'package:skooldio_flutter_1/todo_event.dart';
import 'package:skooldio_flutter_1/todo_item.dart';
import 'package:skooldio_flutter_1/todo_provider.dart';
import 'package:skooldio_flutter_1/todo_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [BlocProvider(create: (context) => TodoBloc())],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              useMaterial3: true,
              primarySwatch: Colors.orange,
              textTheme: GoogleFonts.latoTextTheme(),
              appBarTheme: const AppBarTheme(
                  foregroundColor: Color.fromARGB(255, 4, 1, 1))),
          // home: const AddTodoPage(),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TodoProvider todoProvider = TodoProvider.instace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
        if (state is initialTodoState) {
          context.read<TodoBloc>().add(FetchTodoEvent());
        }

        if (state is TodoListState) {
          var items = state.todos;
          return ListView.builder(
              itemCount: items.length,
              itemBuilder: ((context, index) {
                var todoItem = items[index];
                return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.endToStart,
                  background: Container(),
                  secondaryBackground: Container(
                    color: Colors.red,
                  ),
                  onDismissed: (direction) {
                    setState(() {
                      todoProvider.deleteTodo(todoItem);
                    });
                  },
                  child: ListTile(
                    title: Text(todoItem.title ?? ""),
                    subtitle: Text(todoItem.notes ?? ""),
                    leading: Checkbox(
                      value: todoItem.done,
                      onChanged: (value) =>
                          _onClickValueChaged(value ?? false, todoItem),
                    ),
                  ),
                );
              }));
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFapClicked,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _onFapClicked() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddTodoPage()))
        .then((value) => {setState(() {})});
  }

  void _onClickValueChaged(bool isChecked, TodoItem item) async {
    TodoItem newItem = TodoItem(
        id: item.id, title: item.title, notes: item.notes, done: isChecked);
    await todoProvider.updateTodo(newItem);
    setState(() {});
  }

  Future<List<TodoItem>> _fetchTodos() async {
    return await todoProvider.fetchTodos();
  }
}
