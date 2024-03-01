import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            TextFormField(
              controller: _controllerEmail,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Введите адрес своей почты',
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
            ),
            TextFormField(
              controller: _controllerPassword,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Придумайте пароль',
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
            ),
            ElevatedButton(
                onPressed: () {
                  _singIn(_controllerEmail.text, _controllerPassword.text);
                },
                child: Container(child: Text('Войти'), color: Colors.cyan)),
          ]),
        ),
      ]),
    );
  }
}

Future<void> _singIn(String emailAddress, String password) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    int a = 0;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    } else if (e.code == 'invalid-credential') {
      AlertDialog(title: Text('Wrong password provided for that user.'));
    }
  }
}


