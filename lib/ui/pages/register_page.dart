import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footer/footer.dart';
import 'package:money_tracker/ui/router.dart';

import '../auth.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({super.key});
  static String get routeName => 'register';
  static String get routeLocation => '/$routeName';

  String email = '';
  String password = '';
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerProvider);
    final state = ref.watch(loadingStateProvider);

    return Scaffold(
        body: Column(children: [
      const Expanded(child: SizedBox(height: 200, width: 200)),
      Expanded(
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
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
              padding: const EdgeInsets.only(left: 15, right: 15),
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
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        _createAccout(
                            _controllerEmail.text, _controllerPassword.text, state);
                      },
                      child: state.isLoading
                          ? const SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(
                                  strokeWidth: 3, color: Colors.white),
                            )
                          : const Text('Регистрация')))),
        ]),
      ),
      Center(
          child: Footer(
        child: Row(children: [
          const Text('Уже есть аккаунт?'),
          TextButton(
              onPressed: () {
                router.go('/login');
              },
              child: const Text('Войти'))
        ]), //The child Widget is mandatory takes any Customisable Widget for the footer
      ))
    ]));
  }
}

Future<void> _createAccout(String emailAddress, String password, state) async {
  try {
    state.startLoader();
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    state.stopLoader();
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
