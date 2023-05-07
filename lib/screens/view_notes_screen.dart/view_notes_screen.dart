import 'package:firebase_note_app/screens/home_screen/home_screen.dart';
import 'package:firebase_note_app/ui_helper.dart';
import 'package:flutter/material.dart';

class ViewNotesScreen extends StatefulWidget {
  ViewNotesScreen(
      {required this.notesId,
      required this.notesTitle,
      required this.notesDesc,
      required this.notesTime,
      super.key});

  var notesId;
  var notesTitle;
  var notesDesc;
  var notesTime;

  @override
  State<ViewNotesScreen> createState() => _ViewNotesScreenState();
}

class _ViewNotesScreenState extends State<ViewNotesScreen> {
  TextEditingController _titleController = TextEditingController();

  TextEditingController _DescController = TextEditingController();

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
                Row(
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
                                  builder: (context) => HomeScreen(),
                                ));
                          },
                          icon: Icon(
                            Icons.navigate_before,
                            size: 30,
                            color: MyColor.bgWColor,
                          )),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => EditContentPage(
                          //           notesId: widget.notesId,
                          //           notesTitle: widget.notesTitle,
                          //           notesDesc: widget.notesDesc),
                          //     ));
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.81,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.notesTitle,
                            style: mTextStyle34(mColor: MyColor.bgWColor)),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          " ${DateTime.parse(widget.notesTime!).day.toString()}-${DateTime.parse(widget.notesTime!).month.toString()}-${DateTime.parse(widget.notesTime!).year.toString()} ",
                          style: mTextStyle16(
                              mColor: MyColor.bgWColor.withOpacity(0.5)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //  TextStyle20(title: context, fontColor: Colors.white),
                        Text(
                          widget.notesDesc,
                          style: mTextStyle34(mColor: MyColor.bgWColor),
                        ),
                      ],
                    ),
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
