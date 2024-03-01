import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/ui/home_page.dart';
import 'package:money_tracker/ui/login_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  // Listen for Auth changes and .refresh the GoRouter [router]
  GoRouter router = RoutingService().router;
  FirebaseAuth.instance.userChanges().listen((User? user) {
    router.refresh();
  });

  runApp(App(router: router));
}

class App extends StatelessWidget {
  const App({super.key, required this.router});
  final GoRouter router;

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    routerConfig: router,
  );
}

class RoutingService {
  final router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const MyHomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginPage(),
      ),
    ],

    // redirect to the login page if the user is not logged in
    redirect: (BuildContext context, GoRouterState state) async {
      final bool loggedIn = FirebaseAuth.instance.currentUser != null;
      final bool loggingIn = state.matchedLocation == '/login';
      if (!loggedIn) return '/login';
      if (loggingIn) return '/';
      // no need to redirect at all
      return null;
    },
  );
}
