import 'package:flutter_modular/flutter_modular.dart';
import 'package:path/path.dart';
import 'package:skooldio_flutter_1/todo_item.dart';
import 'package:sqflite/sqflite.dart';

class TodoProvider {
  static const TODO_TABLE = 'TodoItemTable';
  static TodoProvider instace = TodoProvider();

  Future<Database> database() async {
    return await openDatabase(join(await getDatabasesPath(), 'todo_item.db'),
        version: 1, onCreate: ((db, version) async {
      await db.execute(
          "CREATE TABLE $TODO_TABLE (id TEXT PRIMARY KEY,title TEXT,notes TEXT,done INTEGER)");
    }));
  }

  Future<List<TodoItem>> fetchTodos() async {
    Database db = await database();
    List<Map<dynamic, dynamic>> todos = await db.query(TODO_TABLE);

    return todos.map((e) => TodoItem.fromMap(e)).toList();
  }

  Future<void> insertTodo(TodoItem item) async {
    Database db = await database();
    db.insert(TODO_TABLE, item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateTodo(TodoItem item) async {
    Database db = await database();
    await db.update(TODO_TABLE, item.toMap(),
        where: "id = ?",
        whereArgs: [item.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteTodo(TodoItem item) async {
    Database db = await database();
    await db.delete(
      TODO_TABLE,
      where: "id = ?",
      whereArgs: [item.id],
    );
  }
}
