import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Center(child: Text('MAIN PAGE')),
    ElevatedButton(
    onPressed: () {
      _singOut();
    },
    child: Container(child: Text('Выйти'), color: Colors.cyan)),

  ]));
  }
}
Future<void> _singOut() async {
  FirebaseAuth.instance.signOut();
}