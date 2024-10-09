import 'package:go_router/go_router.dart';
import 'package:standmaster/providers/auth_provider.dart';
import 'package:standmaster/providers/auth_user.dart';

import 'package:standmaster/router/child/bottom_navigation.dart';
import 'package:standmaster/router/child/routes.dart';
import 'package:standmaster/screens/child/kermesse_details_screen.dart';
import 'package:standmaster/screens/child/kermesse_interaction_details_screen.dart';
import 'package:standmaster/screens/child/kermesse_interaction_list_screen.dart';
import 'package:standmaster/screens/child/kermesse_list_screen.dart';
import 'package:standmaster/screens/child/kermesse_stand_details_screen.dart';
import 'package:standmaster/screens/child/kermesse_stand_list_screen.dart';
import 'package:standmaster/screens/child/kermesse_tombola_details_screen.dart';
import 'package:standmaster/screens/child/kermesse_tombola_list_screen.dart';
import 'package:standmaster/screens/child/ticket_details_screen.dart';
import 'package:standmaster/screens/child/ticket_list_screen.dart';
import 'package:standmaster/screens/child/user_details_screen.dart';
import 'package:standmaster/screens/child/user_edit_screen.dart';
import 'package:provider/provider.dart';

class ChildRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return ChildBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ChildRoutes.kermesseList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KermesseListScreen(),
            ),
          ),
          GoRoute(
            path: ChildRoutes.kermesseDetails,
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
            path: ChildRoutes.kermesseStandList,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseStandListScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ChildRoutes.kermesseStandDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseStandDetailsScreen(
                  kermesseId: params['kermesseId']!,
                  standId: params['standId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ChildRoutes.kermesseInteractionList,
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
            path: ChildRoutes.kermesseInteractionDetails,
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
          GoRoute(
            path: ChildRoutes.kermesseTombolaList,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseTombolaListScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ChildRoutes.kermesseTombolaDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseTombolaDetailsScreen(
                  kermesseId: params['kermesseId']!,
                  tombolaId: params['tombolaId']!,
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ChildRoutes.ticketList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TicketListScreen(),
            ),
          ),
          GoRoute(
            path: ChildRoutes.ticketDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: TicketDetailsScreen(
                  ticketId: params['ticketId']!,
                ),
              );
            },
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ChildRoutes.userDetails,
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
            path: ChildRoutes.userEdit,
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
      )
    ],
  );
}
