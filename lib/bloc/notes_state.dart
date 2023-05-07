part of 'notes_bloc.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoadingStates extends NotesState {}

class NotesLoadedStates extends NotesState {
  final List<NotesModel> arrNotes;
  NotesLoadedStates(this.arrNotes);
}

class NotesErrorStates extends NotesState {
  String errorMsg;
  NotesErrorStates(this.errorMsg);
}
