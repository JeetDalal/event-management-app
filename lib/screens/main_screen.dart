import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseapp/modals/noteslist.dart';
import 'package:firebaseapp/widgets/notescard.dart';
import 'package:flutter/material.dart';

// import '../modals/note.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  NotesList myNotes = NotesList();

  @override
  Widget build(BuildContext context) {
    List<String> docIds = [];
    // final userDetails = ModalRoute.of(context)!.settings.arguments as String;
    final userDetails = FirebaseAuth.instance.currentUser;
    // final email = userDetails!.email;
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('note1');

    void getNotes() async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('note1')
          .get()
          .then(
            (value) => value.docs.forEach(
              (element) {
                log(element.reference.id);
                docIds.add(element.reference.id);
              },
            ),
          );
    }

    getNotes();
    // final email = userDetails.;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        onPressed: () {
          Navigator.of(context).pushNamed('/notes-page');
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          'Notes',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          return !snapshot.hasData
              ? const Text('No Notes')
              : GridView.builder(
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    // log(snapshot.data!.docs.length as String);
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: NotesCard(
                        title: (snapshot.data!.docs[index].data()
                            as Map<String, dynamic>)['title'],
                        description: (snapshot.data!.docs[index].data()
                            as Map<String, dynamic>)['description'],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
