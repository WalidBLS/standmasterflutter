import 'package:go_router/go_router.dart';
import 'package:standmaster/providers/auth_provider.dart';
import 'package:standmaster/providers/auth_user.dart';

import 'package:standmaster/router/stand_holder/bottom_navigation.dart';
import 'package:standmaster/router/stand_holder/routes.dart';
import 'package:standmaster/screens/stand_holder/kermesse_details_screen.dart';
import 'package:standmaster/screens/stand_holder/kermesse_interaction_details_screen.dart';
import 'package:standmaster/screens/stand_holder/kermesse_interaction_list_screen.dart';
import 'package:standmaster/screens/stand_holder/kermesse_list_screen.dart';
import 'package:standmaster/screens/stand_holder/stand_create_screen.dart';
import 'package:standmaster/screens/stand_holder/stand_details_screen.dart';
import 'package:standmaster/screens/stand_holder/stand_edit_screen.dart';
import 'package:standmaster/screens/stand_holder/user_details_screen.dart';
import 'package:standmaster/screens/stand_holder/user_edit_screen.dart';
import 'package:provider/provider.dart';

class StandHolderRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return StandHolderBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: StandHolderRoutes.kermesseList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KermesseListScreen(),
            ),
          ),
          GoRoute(
            path: StandHolderRoutes.kermesseDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseDetailsScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: StandHolderRoutes.kermesseInteractionList,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseInteractionListScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: StandHolderRoutes.kermesseInteractionDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseInteractionDetailsScreen(
                  kermesseId: params['kermesseId']!,
                  interactionId: params['interactionId']!,
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: StandHolderRoutes.standDetails,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: StandDetailsScreen(),
            ),
          ),
          GoRoute(
            path: StandHolderRoutes.standEdit,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: StandEditScreen(),
            ),
          ),
          GoRoute(
            path: StandHolderRoutes.standCreate,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: StandCreateScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: StandHolderRoutes.userDetails,
            pageBuilder: (context, state) {
              AuthUser user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              return NoTransitionPage(
                child: UserDetailsScreen(
                  userId: user.id,
                ),
              );
            },
          ),
          GoRoute(
            path: StandHolderRoutes.userEdit,
            pageBuilder: (context, state) {
              AuthUser user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              return NoTransitionPage(
                child: UserEditScreen(
                  userId: user.id,
                ),
              );
            },
          ),
        ],
      ),
    ],
  );
}
