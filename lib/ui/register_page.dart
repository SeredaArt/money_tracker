import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email = '';
  String password = '';
  TextEditingController? _controllerEmail;
  TextEditingController? _controllerPassword;

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
                  hintText: 'Введите e-mail',
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
              ),
              ElevatedButton(
                  onPressed: () {
                    _createAccout(_controllerEmail!.text, _controllerPassword!.text);
                  },
                  child: Container(child: Text('Регистрация'), color: Colors.cyan)),
            ]),
          )
        ]));
  }
}

Future<void> _createAccout(String emailAddress, String password) async {
  try {
    final credential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
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
