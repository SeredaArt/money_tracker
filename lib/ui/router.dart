import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:money_tracker/ui/register_page.dart';
import 'package:money_tracker/ui/splash_page.dart';
import 'auth.dart';
import 'home_page.dart';
import 'login_page.dart';

final _key = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {

  final authState = ref.watch(authProvider);

  return GoRouter(
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: LoginPage.routeLocation,
    routes: [
      GoRoute(
        path: RegisterPage.routeLocation,
        name: RegisterPage.routeName,
        builder: (context, state) {
          return RegisterPage();
        },
      ),
      // GoRoute(
      //   path: SplashPage.routeLocation,
      //   name: SplashPage.routeName,
      //   builder: (context, state) {
      //     return const SplashPage();
      //   },
      // ),
      GoRoute(
        path: HomePage.routeLocation,
        name: HomePage.routeName,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: LoginPage.routeLocation,
        name: LoginPage.routeName,
        builder: (context, state) {
          return LoginPage();
        },
      ),
    ],
    redirect: (context, state) {
      // If our async state is loading, don't perform redirects, yet
      if (authState.isLoading || authState.hasError) return null;

      // Here we guarantee that hasData == true, i.e. we have a readable value

      // This has to do with how the FirebaseAuth SDK handles the "log-in" state
      // Returning `null` means "we are not authorized"
      final isAuth = authState.valueOrNull != null;

      final isRegister = state.matchedLocation == RegisterPage.routeLocation;
      if (isRegister) {
        return isAuth ? HomePage.routeLocation : RegisterPage.routeLocation;
      }

      final isLoggingIn = state.matchedLocation == LoginPage.routeLocation;
      if (isLoggingIn) return isAuth ? HomePage.routeLocation : null;

      // final isSplash = state.matchedLocation == SplashPage.routeLocation;
      // if (isSplash) {
      return isAuth ? HomePage.routeLocation : null;
      // }

       return isAuth ? null : SplashPage.routeLocation;
    },
  );
});
