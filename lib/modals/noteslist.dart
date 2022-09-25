import 'package:flutter/material.dart';

import 'note.dart';

class NotesList {
  List<Note> notes = [
    Note(
      description: 'Hi! This is my first note.',
      title: 'Test Note',
    ),
  ];
  // List<Note> get notes => [..._notes];

  // void addNote(String title, String description) {
  //   notes.add(
  //     Note(
  //       title: title,
  //       description: description,
  //     ),
  //   );
  // }

  void saveNote() {}

  void deleteNote() {}
}
