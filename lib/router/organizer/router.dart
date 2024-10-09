import 'package:go_router/go_router.dart';
import 'package:standmaster/providers/auth_provider.dart';
import 'package:standmaster/providers/auth_user.dart';
import 'package:standmaster/router/organizer/bottom_navigation.dart';

import 'package:standmaster/router/organizer/routes.dart';
import 'package:standmaster/screens/organizer/kermesse_create_screen.dart';
import 'package:standmaster/screens/organizer/kermesse_details_screen.dart';
import 'package:standmaster/screens/organizer/kermesse_edit_screen.dart';
import 'package:standmaster/screens/organizer/kermesse_interaction_details_screen.dart';
import 'package:standmaster/screens/organizer/kermesse_interaction_list_screen.dart';
import 'package:standmaster/screens/organizer/kermesse_list_screen.dart';
import 'package:standmaster/screens/organizer/kermesse_stand_invite_screen.dart';
import 'package:standmaster/screens/organizer/kermesse_stand_list_screen.dart';
import 'package:standmaster/screens/organizer/kermesse_tombola_create_screen.dart';
import 'package:standmaster/screens/organizer/kermesse_tombola_details_screen.dart';
import 'package:standmaster/screens/organizer/kermesse_tombola_edit_screen.dart';
import 'package:standmaster/screens/organizer/kermesse_tombola_list_screen.dart';
import 'package:standmaster/screens/organizer/kermesse_user_invite_screen.dart';
import 'package:standmaster/screens/organizer/kermesse_user_list_screen.dart';
import 'package:standmaster/screens/organizer/ticket_details_screen.dart';
import 'package:standmaster/screens/organizer/ticket_list_screen.dart';
import 'package:standmaster/screens/organizer/user_details_screen.dart';
import 'package:standmaster/screens/organizer/user_edit_screen.dart';
import 'package:provider/provider.dart';

class OrganizerRouter {
  static StatefulShellRoute routes = StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return OrganizerBottomNavigation(navigationShell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: OrganizerRoutes.kermesseList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KermesseListScreen(),
            ),
          ),
          GoRoute(
            path: OrganizerRoutes.kermesseDetails,
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
            path: OrganizerRoutes.kermesseCreate,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: KermesseCreateScreen(),
            ),
          ),
          GoRoute(
            path: OrganizerRoutes.kermesseEdit,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseEditScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: OrganizerRoutes.kermesseUserList,
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
            path: OrganizerRoutes.kermesseUserInvite,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseUserInviteScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: OrganizerRoutes.kermesseStandList,
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
            path: OrganizerRoutes.kermesseStandInvite,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseStandInviteScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: OrganizerRoutes.kermesseTombolaList,
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
            path: OrganizerRoutes.kermesseTombolaDetails,
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
          GoRoute(
            path: OrganizerRoutes.kermesseTombolaCreate,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseTombolaCreateScreen(
                  kermesseId: params['kermesseId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: OrganizerRoutes.kermesseTombolaEdit,
            pageBuilder: (context, state) {
              final params =
                  GoRouterState.of(context).extra as Map<String, int>;
              return NoTransitionPage(
                child: KermesseTombolaEditScreen(
                  kermesseId: params['kermesseId']!,
                  tombolaId: params['tombolaId']!,
                ),
              );
            },
          ),
          GoRoute(
            path: OrganizerRoutes.kermesseInteractionList,
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
            path: OrganizerRoutes.kermesseInteractionDetails,
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
            path: OrganizerRoutes.ticketList,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: TicketListScreen(),
            ),
          ),
          GoRoute(
            path: OrganizerRoutes.ticketDetails,
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
            path: OrganizerRoutes.userDetails,
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
            path: OrganizerRoutes.userEdit,
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
