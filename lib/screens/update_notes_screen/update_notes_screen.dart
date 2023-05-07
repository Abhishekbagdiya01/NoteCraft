import 'package:firebase_note_app/bloc/notes_bloc.dart';
import 'package:firebase_note_app/models/notes_model.dart';
import 'package:firebase_note_app/screens/home_screen/home_screen.dart';
import 'package:firebase_note_app/screens/view_notes_screen.dart/view_notes_screen.dart';
import 'package:firebase_note_app/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateNoteScreen extends StatelessWidget {
  UpdateNoteScreen(
      {required this.noteId,
      required this.notesTitle,
      required this.notesDesc,
      super.key});
  var noteId;
  var notesTitle;
  var notesDesc;
  var titleController = TextEditingController();

  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = notesTitle;
    descController.text = notesDesc;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade800,
                            borderRadius: BorderRadius.circular(15)),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewNotesScreen(
                                        noteId: noteId,
                                        notesTitle: notesTitle,
                                        notesDesc: notesDesc),
                                  ));
                            },
                            icon: Icon(
                              Icons.navigate_before,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          notesTitle = titleController.text;
                          notesDesc = descController.text;

                          print("noteId : " + noteId);
                          NotesModel newNotesModel = NotesModel(
                              id: noteId,
                              title: notesTitle,
                              desc: notesDesc,
                              dateTime: DateTime.now().toString());
                          BlocProvider.of<NotesBloc>(context).add(
                              UpdateNotesEvent(
                                  noteId: noteId, model: newNotesModel));

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewNotesScreen(
                                  noteId: noteId,
                                  notesTitle: notesTitle,
                                  notesDesc: notesDesc,
                                  notesTime: newNotesModel.dateTime,
                                ),
                              ));
                        },
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              "Save",
                              style: mTextStyle34(mColor: MyColor.bgWColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      TextField(
                        maxLines: 1,
                        controller: titleController,
                        style: TextStyle(color: Colors.white, fontSize: 35),
                        decoration: InputDecoration(
                          hintText: "Title",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 40),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        maxLines: 4,
                        controller: descController,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                        decoration: InputDecoration(
                          hintText: "Type something.....",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
