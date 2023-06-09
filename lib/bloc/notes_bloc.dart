import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note_app/models/notes_model.dart';
import 'package:meta/meta.dart';
part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(NotesInitial()) {
    on<AddNotesEvent>((event, emit) async {
      emit(NotesLoadingStates());
      User? currentUser = await FirebaseAuth.instance.currentUser!;

      // generate a unique document ID in Firebase Firestore and assign it to variable noteId
      String noteId =
          FirebaseFirestore.instance.collection(currentUser.email!).doc().id;
      print("notes Id  : " + noteId);

      await FirebaseFirestore.instance
          .collection(currentUser.email!)
          .doc(noteId)
          .set(NotesModel(
                  id: noteId,
                  title: event.model.title,
                  desc: event.model.desc,
                  dateTime: event.model.dateTime)
              .toJson())
          .then((value) {
        print("Note added");
        print("notes Id  : " + noteId);
      });

      // emit(NotesLoadedStates(arrNotes));
    });

    on<FetchNoteEvent>(
      (event, emit) async {
        emit(NotesLoadingStates());
        User? currentUser = await FirebaseAuth.instance.currentUser!;
        print("CurrentUser" + currentUser.toString());
        List<NotesModel> arrNotes = [];
        arrNotes = await FirebaseFirestore.instance
            .collection(currentUser.email!)
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            arrNotes
                .add(NotesModel.fromJson(doc.data() as Map<String, dynamic>));
          });
          return arrNotes;
        });

        print(arrNotes);
        emit(NotesLoadedStates(arrNotes));
      },
    );

    on<UpdateNotesEvent>(
      (event, emit) async {
        emit(NotesLoadingStates());
        User? currentUser = await FirebaseAuth.instance.currentUser!;
        FirebaseFirestore.instance
            .collection(currentUser.email!)
            .doc(event.noteId)
            .update(NotesModel(
                    id: event.noteId,
                    title: event.model.title,
                    desc: event.model.desc,
                    dateTime: event.model.dateTime)
                .toJson());
      },
    );

    on<DeleteNoteEvent>(
      (event, emit) async {
        emit(NotesLoadingStates());

        User? currentUser = await FirebaseAuth.instance.currentUser!;
        await FirebaseFirestore.instance
            .collection(currentUser.email!)
            .doc(event.notesId)
            .delete();

        List<NotesModel> arrNotes = [];
        arrNotes = await FirebaseFirestore.instance
            .collection(currentUser.email!)
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            arrNotes
                .add(NotesModel.fromJson(doc.data() as Map<String, dynamic>));
          });
          return arrNotes;
        });
        emit(NotesLoadedStates(arrNotes));
      },
    );

    on<SearchNotesEvent>(
      (event, emit) async {
        emit(NotesLoadingStates());
        User? currentUser = await FirebaseAuth.instance.currentUser!;
        var arrNotes = <NotesModel>[];
        arrNotes = await FirebaseFirestore.instance
            .collection(currentUser.email!)
            .where('title', isGreaterThanOrEqualTo: event.searchQuery)
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            arrNotes
                .add(NotesModel.fromJson(doc.data() as Map<String, dynamic>));
          });
          return arrNotes;
        });
        emit(NotesLoadedStates(arrNotes));
      },
    );
  }
}
