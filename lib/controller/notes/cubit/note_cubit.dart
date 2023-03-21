import 'package:bloc/bloc.dart';

import 'package:todo/data/database/note_operations.dart';

import '../../../data/models/note.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  List<Note> notes = [];

  Future<void> getNotes() async {
    try {
      final results = await NoteDB().select();
      notes = results.map((note) => Note.fromMap(note)).toList();
      emit(NoteLoaded(notes: notes));
    } catch (e) {
      emit(NoteFailure(error: e.toString()));
    }
  }

  Future<void> insertNote(Note note) async {
    try {
      final result = await NoteDB().insert(note);
      notes.add(result);
      emit(NoteLoaded(notes: notes));
    } catch (e) {
      emit(NoteFailure(error: e.toString()));
    }
  }

  Future<void> deleteNote(Note note) async {
    try {
      final result = await NoteDB().delete(note);
      print('$result row deleted');
      notes.removeWhere((x) => x.id == note.id);
      emit(NoteLoaded(notes: notes));
    } catch (e) {
      emit(NoteFailure(error: e.toString()));
    }
  }

  Future<void> updateNote(Note note) async {
    try {
      final result = await NoteDB().update(note);
      print('$result row updated');
      final index = notes.indexWhere((element) => element.id == note.id);
      notes[index] = result;
      emit(NoteLoaded(notes: notes));
    } catch (e) {
      emit(NoteFailure(error: e.toString()));
    }
  }
}
