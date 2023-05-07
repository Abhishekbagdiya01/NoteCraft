part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class AddNotesEvent extends NotesEvent {
  NotesModel model;
  AddNotesEvent(this.model);
}

class FetchNoteEvent extends NotesEvent {}

class DeleteNoteEvent extends NotesEvent {
  String notesId;
  DeleteNoteEvent(this.notesId);
}
