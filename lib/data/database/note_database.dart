import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteDatabase {
  Database? _database;

  static const _verison = 3;
  static const _databaseName = 'note.db';
  static const tableName = 'notes';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDatabase();

      return _database!;
    }
  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);

    return await openDatabase(path,
        version: _verison, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  FutureOr<void> _onCreate(Database db, int version) {
    db.execute('''
  CREATE TABLE $tableName (
  id integer primary key AUTOINCREMENT,
  title text not null,
  content text not null,
  datetime text not null,
  isImportant integer not null,
  isTodo integer not null);  
  ''');
    // ignore: avoid_print
    print('table created');
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    // ignore: avoid_print
  }

  deleteDB() async {
    final path = join(await getDatabasesPath(), _databaseName);
    await deleteDatabase(path);
  }
}
