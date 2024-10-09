import 'package:go_router/go_router.dart';
import 'package:standmaster/providers/auth_provider.dart';
import 'package:standmaster/providers/auth_user.dart';

import 'package:standmaster/router/parent/bottom_navigation.dart';
import 'package:standmaster/router/parent/routes.dart';
import 'package:standmaster/screens/parent/children_details_screen.dart';
import 'package:standmaster/screens/parent/children_invite_screen.dart';
import 'package:standmaster/screens/parent/children_list_screen.dart';
import 'package:standmaster/screens/parent/kermesse_details_screen.dart';
import 'package:standmaster/screens/parent/kermesse_interaction_details_screen.dart';
import 'package:standmaster/screens/parent/kermesse_interaction_list_screen.dart';
import 'package:standmaster/screens/parent/kermesse_list_screen.dart';
import 'package:standmaster/screens/parent/kermesse_stand_details_screen.dart';
import 'package:standmaster/screens/parent/kermesse_stand_list_screen.dart';
import 'package:standmaster/screens/parent/kermesse_user_list_screen.dart';
import 'package:standmaster/screens/parent/ticket_details_screen.dart';
import 'package:standmaster/screens/parent/ticket_list_screen.dart';
import 'package:standmaster/screens/parent/user_credit_edit_screen.dart';
import 'package:standmaster/screens/parent/user_details_screen.dart';
import 'package:standmaster/screens/parent/user_edit_screen.dart';
import 'package:provider/provider.dart';

class ParentRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return ParentBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ParentRoutes.kermesseList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KermesseListScreen(),
            ),
          ),
          GoRoute(
            path: ParentRoutes.kermesseDetails,
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
            path: ParentRoutes.kermesseUserList,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseUserListScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ParentRoutes.kermesseStandList,
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
            path: ParentRoutes.kermesseStandDetails,
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
            path: ParentRoutes.kermesseInteractionList,
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
            path: ParentRoutes.kermesseInteractionDetails,
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
            path: ParentRoutes.childrenList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ChildrenListScreen(),
            ),
          ),
          GoRoute(
            path: ParentRoutes.childrenDetails,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: ChildrenDetailsScreen(
                  userId: params['userId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: ParentRoutes.childrenInvite,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ChildrenInviteScreen(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: ParentRoutes.ticketList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TicketListScreen(),
            ),
          ),
          GoRoute(
            path: ParentRoutes.ticketDetails,
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
            path: ParentRoutes.userDetails,
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
            path: ParentRoutes.userEdit,
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
          GoRoute(
            path: ParentRoutes.userCreditEdit,
            pageBuilder: (context, state) {
              AuthUser user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              return NoTransitionPage(
                child: UserCreditEditScreen(
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
