import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:go_router/go_router.dart';

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
        Expanded(child: Center()),
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
                          _singIn(
                              _controllerEmail.text, _controllerPassword.text);
                        },
                        child: Text('Войти')))),
          ]),
        ),
        Center(child: Footer(
            child:
               Row(children: [Text('Eщё нет аккаунта?'), TextButton(onPressed: () {

                 setState(() {
                   context.go('/register');
                 });
               }, child: Text('Регистрация'))]), //The child Widget is mandatory takes any Customisable Widget for the footer

            ))
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
