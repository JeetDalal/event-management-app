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
    // final userDetails = ModalRoute.of(context)!.settings.arguments as String;
    final userDetails = FirebaseAuth.instance.currentUser;
    final email = userDetails!.email;

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
      body: GridView.builder(
        itemCount: myNotes.notes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            child: NotesCard(
              title: myNotes.notes[index].title,
              description: myNotes.notes[index].description,
            ),
          );
        },
      ),
    );
  }
}
