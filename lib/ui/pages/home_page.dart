import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});
  static String get routeName => 'home';
  static String get routeLocation => '/';
  final _nameController = TextEditingController();
  final _colorController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    CollectionReference categories =
        FirebaseFirestore.instance.collection('categories');

    Future<void> addCategory(String name, String color) {
      return categories
          .add({
            'color': color,
            'name': name,
          })
          .then((value) => print("Categories Added"))
          .catchError((error) => print("Failed to add categories: $error"));
    }

    ;

    Future createCategoryForm() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Create category'),
              content: Column(children: [
                TextField(
                    decoration: const InputDecoration(hintText: 'Name'),
                    controller: _nameController),
                TextField(
                    decoration: const InputDecoration(hintText: 'Color'),
                    controller: _colorController)
              ]),
              actions: [
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                         addCategory(
                              _nameController.text, _colorController.text);
                        },
                        child: Text('Добавить')),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Отмена')),
                  ],
                )
              ],
            ));

    return Scaffold(
        appBar: AppBar(actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add category',
              onPressed: () {
                createCategoryForm();
              })
        ]),
        body: Column(children: [
          const Center(child: Text('MAIN PAGE')),
          ElevatedButton(
              onPressed: () {
                _singOut();
              },
              child: const Text('Выйти')),
        ]));
  }
}

Future<void> _singOut() async {
  FirebaseAuth.instance.signOut();
}
