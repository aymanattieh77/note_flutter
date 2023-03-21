// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'note_cubit.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoaded extends NoteState {
  final List<Note> notes;
  NoteLoaded({
    required this.notes,
  });
}

class NoteLoading extends NoteState {}

class NoteFailure extends NoteState {
  final String error;
  NoteFailure({
    required this.error,
  });
}
