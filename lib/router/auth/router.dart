import 'package:go_router/go_router.dart';

import 'package:standmaster/router/auth/routes.dart';
import 'package:standmaster/screens/auth/sign_in_screen.dart';
import 'package:standmaster/screens/auth/sign_up_screen.dart';

class AuthRouter {
  static List<RouteBase> routes = [
    GoRoute(
      path: AuthRoutes.signIn,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SignInScreen(),
      ),
    ),
    GoRoute(
      path: AuthRoutes.signUp,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: SignUpScreen(),
      ),
    ),
  ];
}
