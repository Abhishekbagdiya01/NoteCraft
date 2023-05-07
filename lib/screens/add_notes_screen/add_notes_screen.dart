import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note_app/bloc/notes_bloc.dart';
import 'package:firebase_note_app/models/notes_model.dart';
import 'package:firebase_note_app/screens/home_screen/home_screen.dart';
import 'package:firebase_note_app/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNotesScreen extends StatefulWidget {
  AddNotesScreen({super.key});

  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  var titleController = TextEditingController();

  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => HomePage(),
                              //     ));
                            },
                            icon: Icon(
                              Icons.navigate_before,
                              size: 30,
                              color: Colors.white,
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          // String? uid = FirebaseAuth.instance.currentUser!.uid;
                          NotesModel newModel = NotesModel(
                              id: "",
                              title: titleController.text,
                              desc: descController.text,
                              dateTime: DateTime.now().toString());
                          BlocProvider.of<NotesBloc>(context)
                              .add(AddNotesEvent(newModel));
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
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
                              style: mTextStyle25(mColor: MyColor.bgWColor),
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
