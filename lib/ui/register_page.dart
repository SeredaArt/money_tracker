import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/ui/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = '';
  String password = '';
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(child: SizedBox(height: 200, width: 200)),
      Expanded(
        child: Column(children: [
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                controller: _controllerEmail,
                decoration: const InputDecoration(
                  // icon: Icon(Icons.person),
                  hintText: 'Введите адрес почты',
                  labelText: 'Email',
                ),
                onSaved: (String? value) {
                  TextInputAction.next;
                },
                validator: (String? value) {
                  return (value != null && value.contains('@'))
                      ? null
                      : 'Адрес почты введён не корректно.';
                },
              )),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: TextFormField(
                controller: _controllerPassword,
                decoration: const InputDecoration(
                  // icon: Icon(Icons.password),
                  hintText: 'Введите пароль',
                  labelText: 'Password',
                ),
                onSaved: (String? value) {
                  TextInputAction.done;
                },
                validator: (String? value) {
                  return (value != null && value.length > 6
                      ? 'Пароль должен быть больше 6 символов.'
                      : null);
                },
              )),
          Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        _createAccout(_controllerEmail.text,
                            _controllerPassword.text, context);
                      },
                      child: Text('Регистрация')))),
        ]),
      ),
      Center(
          child: Footer(
        child: Row(children: [
          Text('Уже есть аккаунт?'),
          TextButton(
              onPressed: () {
                setState(() {
                  context.go('/login');
                });
              },
              child: Text('Войти'))
        ]), //The child Widget is mandatory takes any Customisable Widget for the footer
      ))
    ]));
  }
}

Future<void> _createAccout(
    String emailAddress, String password, context) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    if (FirebaseAuth.instance.currentUser == null) {
      return;
    } else {
      context.go('/login');
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
