import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sql1_week10/model/to_do.dart';

final String todoTable = 'todo';

class DBHelper {
  static final DBHelper instance = DBHelper.internal();

  factory DBHelper() => instance;

  DBHelper.internal();

  static Database? db;

  Future<Database?> createDatabase() async {
    if (db != null) {
      return db;
    }
    String? path = join(await getDatabasesPath(), 'todo.db');
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) {
      db.execute('create table todo'
          ' (id integer primary key autoincrement,'
          'name varchar(50),'
          'date varchar (255),'
          'isChecked integer');
    });
    return db;
  }

  Future<ToDo> insertTodo(ToDo todo) async {
    todo.id = await db!.insert(todoTable, todo.toMap());
    return todo;
  }

  Future<List<ToDo>> getAllTodo() async {
    List<Map<String, dynamic>> todoMaps = await db!.query(todoTable);
    if (todoMaps.length == 0)
      return [];
    else {
      List<ToDo> todos = [];
      todoMaps.forEach((element) {
        todos.add(ToDo.fromMap(element));
      });
      return todos;
    }
  }
}
