import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/modals/noteslist.dart';
import 'package:firebaseapp/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../modals/note.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  int i = 1;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  NotesList myNotes = NotesList();

  // void addNote(String title, String description) {
  //   setState(() {
  //     myNotes.notes.add(
  //       Note(title: title, description: description),
  //     );
  //   });
  // }
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () async {
          myNotes.notes.add(
            Note(
              title: _titleController.text,
              description: _descriptionController.text,
            ),
          );
          try {
            await ref
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('note1')
                .add({
              'title': _titleController.text,
              'description': _descriptionController.text,
            }).then((value) => Navigator.of(context).pop());
          } on FirebaseFirestore catch (e) {
            log(e.toString());
          }
        },
        child: const Icon(Icons.save),
      ),
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: Text(_titleController.text),
      ),
      backgroundColor: Colors.yellow[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Title',
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'type here...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
