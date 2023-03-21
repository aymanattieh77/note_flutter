import 'package:todo/data/database/note_database.dart';

import '../models/note.dart';

class NoteDB {
  Future<Note> insert(Note note) async {
    final db = await NoteDatabase().database;
    int id = await db.insert(NoteDatabase.tableName, note.toMap());
    print('$id row inserted');

    return note.copyWith(id: id);
  }

  Future<Note> update(Note note) async {
    final db = await NoteDatabase().database;
    int id = await db.update(NoteDatabase.tableName, note.toMap(),
        where: 'id = ?', whereArgs: [note.id]);
    return note.copyWith(id: id);
  }

  Future<int> delete(Note note) async {
    final db = await NoteDatabase().database;
    int id = await db
        .delete(NoteDatabase.tableName, where: 'id = ?', whereArgs: [note.id]);
    return id;
  }

  Future<List<Map<String, Object?>>> select() async {
    final db = await NoteDatabase().database;
    return db.query(
      NoteDatabase.tableName,
      columns: [
        'id',
        'title',
        'content',
        'datetime',
        'isImportant',
        'isToDo',
      ],
    );
  }

  close() async {
    final db = await NoteDatabase().database;
    await db.close();
  }
}
