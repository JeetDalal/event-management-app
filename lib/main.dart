import 'package:firebaseapp/screens/main_screen.dart';
import 'package:firebaseapp/screens/note_screen.dart';
import 'package:flutter/material.dart';

import 'screens/home_page.dart';
import 'screens/register.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/register-page': (context) => const RegisterPage(),
        '/main-page': (context) => MainPage(),
        '/notes-page': (context) => const NotesScreen(),
      },
    );
  }
}
