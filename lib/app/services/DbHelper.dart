import 'package:expense_tracker/app/data/expense.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;

  DbHelper._createObject();

  factory DbHelper() {
    _dbHelper ??= DbHelper._createObject();
    return _dbHelper!;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}expense.db';
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expense(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        amount INTEGER,
        is_income INTEGER,
        description TEXT,
        created_at INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INTEGER)),
        updated_at INTEGER NOT NULL DEFAULT (CAST(strftime('%s', 'now') AS INTEGER))
      )
    ''');
  }

  Future<Database> get database async {
    _database ??= await initDb();
    return _database!;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await database;
    var mapList = await db.query('expense', orderBy: 'created_at');
    return mapList;
  }

  Future<int> insert(Expense object) async {
    Database db = await database;
    int count = await db.insert('expense', object.toMapDB());
    return count;
  }

  Future<int> update(Expense object) async {
    Database db = await database;
    int count = await db.update('expense', object.toMapDB(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await database;
    int count = await db.delete('expense', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Expense>> getExpenseList() async {
    var expenseMapList = await select();
    List<Expense> expenseList = <Expense>[];
    for (var element in expenseMapList) {
      expenseList.add(Expense.fromMap(element));
    }
    return expenseList;
  }
}
