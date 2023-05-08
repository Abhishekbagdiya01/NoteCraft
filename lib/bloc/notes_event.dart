part of 'notes_bloc.dart';

@immutable
abstract class NotesEvent {}

class AddNotesEvent extends NotesEvent {
  NotesModel model;
  AddNotesEvent(this.model);
}

class FetchNoteEvent extends NotesEvent {}

class UpdateNotesEvent extends NotesEvent {
  String noteId;
  NotesModel model;
  UpdateNotesEvent({required this.noteId, required this.model});
}

class DeleteNoteEvent extends NotesEvent {
  String notesId;
  DeleteNoteEvent(this.notesId);
}

class SearchNotesEvent extends NotesEvent {
  String searchQuery;
  SearchNotesEvent(this.searchQuery);
}
