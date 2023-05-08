import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_note_app/bloc/notes_bloc.dart';
import 'package:firebase_note_app/models/notes_model.dart';
import 'package:firebase_note_app/screens/add_notes_screen/add_notes_screen.dart';
import 'package:firebase_note_app/screens/user_onboarding/sign_up/sign_up_screen.dart';

import 'package:firebase_note_app/screens/view_notes_screen.dart/view_notes_screen.dart';
import 'package:firebase_note_app/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    BlocProvider.of<NotesBloc>(context).add(FetchNoteEvent());
    super.initState();
  }

  // List arrNotes = [
  //   {'title': "This is title", 'desc': 'This is desc'},
  //   {'title': "This is title", 'desc': 'This is desc'},
  //   {'title': "This is title", 'desc': 'This is desc'},
  //   {'title': "This is title", 'desc': 'This is desc'},
  //   {'title': "This is title", 'desc': 'This is desc'},
  // ];

  List<NotesModel> arrNotes = [];
  var size = const SizedBox(
    height: 8,
  );
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
                    Text(
                      "Notes",
                      style: mTextStyle34(mColor: MyColor.bgWColor),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut().then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ));
                          });
                        },
                        icon: Icon(
                          Icons.logout,
                          size: 34,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  // height: MediaQuery.of(context).size.height * 0.81,
                  child: BlocBuilder<NotesBloc, NotesState>(
                builder: (context, state) {
                  if (state is NotesLoadingStates) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NotesLoadedStates) {
                    arrNotes = state.arrNotes;
                    return MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      itemCount: arrNotes.length,
                      itemBuilder: (context, index) {
                        return StaggeredGridTile.count(
                          crossAxisCellCount: 4,
                          mainAxisCellCount: 4,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewNotesScreen(
                                        noteId: arrNotes[index].id,
                                        notesTitle: arrNotes[index].title,
                                        notesDesc: arrNotes[index].desc,
                                        notesTime: arrNotes[index].dateTime,
                                      )));
                            },
                            onLongPress: () {
                              BlocProvider.of<NotesBloc>(context)
                                  .add(DeleteNoteEvent(arrNotes[index].id!));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: index % 2 == 0
                                      ? Colors.red
                                      : index % 3 == 1
                                          ? Colors.green
                                          : Colors.yellow,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    size,
                                    Text(
                                      arrNotes[index].title!,
                                      style: mTextStyle16(
                                          mColor: MyColor.bgWColor),
                                    ),
                                    size,
                                    Text(
                                      arrNotes[index].desc!,
                                      style: mTextStyle16(
                                          mColor: MyColor.bgWColor),
                                    ),
                                    size,
                                    Text(
                                      " ${DateTime.parse(arrNotes[index].dateTime!).day.toString()}-${DateTime.parse(arrNotes[index].dateTime!).month.toString()}-${DateTime.parse(arrNotes[index].dateTime!).year.toString()} ",
                                      style: mTextStyle16(
                                          mColor: MyColor.bgWColor
                                              .withOpacity(0.6)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is NotesErrorStates) {
                    return Center(
                      child: Text(state.errorMsg),
                    );
                  } else {
                    return Center(child: Text("Something went wrong"));
                  }
                },
              ))
            ],
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 30, 29, 29),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return AddNotesScreen();
            },
          ));
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
