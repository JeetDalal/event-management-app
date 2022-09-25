import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late String errorText;

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(200, 210, 227, 1),
        body: Center(
          child: FutureBuilder(
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: ((context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Column(
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
                      Text(
                        errorText,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                          final email = _emailController.text;
                          final password = _passwordController.text;
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            setState(() {
                              errorText = '';
                            });
                            Navigator.of(context)
                                .pushReplacementNamed('/main-page');
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              setState(() {
                                errorText = 'Invalid Email';
                              });
                              log(errorText);
                            } else if (e.code == 'wrong-password') {
                              setState(() {
                                errorText = 'Incorrect Password';
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
                              'Sign In',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Not Registered Yet?',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/register-page');
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                  break;
                default:
                  return const Center(
                    child: Text('Loading...'),
                  );
              }
            }),
          ),
        ),
      ),
    );
  }
}
