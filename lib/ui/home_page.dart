import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});
  static String get routeName => 'home';
  static String get routeLocation => '/';


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      body: Column(children: [
        Center(child: Text('MAIN PAGE')),
    ElevatedButton(
    onPressed: () {
      _singOut();
    },
    child: Text('Выйти')),

  ]));
  }
}
Future<void> _singOut() async {
  FirebaseAuth.instance.signOut();
}