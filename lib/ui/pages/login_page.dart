import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:footer/footer.dart';
import 'package:money_tracker/ui/router.dart';
import '../auth.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  static String get routeName => 'login';
  static String get routeLocation => '/$routeName';

  String email = '';
  String password = '';
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerProvider);
    final state = ref.watch(loadingStateProvider);

    return
      Scaffold(
      body: Column(children: [
        const Expanded(child: Center()),
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
                          _singIn(
                              _controllerEmail.text, _controllerPassword.text, state);
                          },
                        child: state.isLoading
                            ? const SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                    strokeWidth: 3, color: Colors.white),
                              )
                            : const Text('Войти')))),
          ]),
        ),
        Center(
            child: Footer(
          child: Row(children: [
            const Text('Eщё нет аккаунта?'),
            TextButton(
                onPressed: () {
                  router.go('/register');
                },
                child: const Text('Регистрация'))
          ]), //The child Widget is mandatory takes any Customisable Widget for the footer
        ))
      ]),
    );
  }
}

Future<void> _singIn(String emailAddress, String password, state) async {


  try {
    state.startLoader();
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
    state.stopLoader();
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    } else if (e.code == 'invalid-credential') {
      const AlertDialog(title: Text('Wrong password provided for that user.'));
    }
  }
}
