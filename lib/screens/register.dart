import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late String errorText = '';

  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    errorText = '';
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(200, 210, 227, 1),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple.shade400,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.arrow_back),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Hello There,',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              // fontStyle: ,
              fontSize: 40,
            ),
          ),
          const Text(
            'We are so glad to see you back here',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              // fontStyle: ,
              fontSize: 15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                height: 60,
                // color: Colors.white,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: TextField(
                      enableSuggestions: false,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                height: 60,
                // color: Colors.white,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: TextField(
                      obscureText: true,
                      autocorrect: false,
                      enableSuggestions: false,
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              try {
                final email = _emailController.text;
                final password = _passwordController.text;
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .set({
                  'notes': [
                    {
                      'title': 'title',
                      'description': 'description',
                    },
                  ],
                }).then((value) => Navigator.of(context).pop());
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  setState(() {
                    errorText = 'Password is Weak';
                  });
                  log(errorText);
                } else if (e.code == 'email-already-in-use') {
                  setState(() {
                    errorText = 'Email Already Exists';
                  });
                  log(errorText);
                } else if (e.code == 'invalid-email') {
                  setState(() {
                    errorText = 'Email is Invalid';
                  });
                  log(errorText);
                }
              }
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              height: 60,
              width: double.infinity,
              // color: Colors.white,
              decoration: BoxDecoration(
                color: Colors.purple.shade400,
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: const Center(
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Text(
            errorText,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
