import 'package:flutter/foundation.dart';

class NotesModel {
  String? id;
  String? title;
  String? desc;
  String? dateTime;

  NotesModel({this.id, this.title, this.desc, this.dateTime});

  factory NotesModel.fromJson(Map<String, dynamic> map) {
    return NotesModel(
        id: map['id'],
        title: map['title'],
        desc: map['desc'],
        dateTime: map['dateTime']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'desc': desc,
      'dateTime': dateTime,
    };
  }
}
