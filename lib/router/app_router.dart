import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:standmaster/providers/auth_user.dart';
import 'package:standmaster/router/child/routes.dart';
import 'package:standmaster/router/organizer/routes.dart';
import 'package:standmaster/router/parent/routes.dart';
import 'package:standmaster/router/stand_holder/routes.dart';
import 'package:standmaster/providers/auth_provider.dart';
import 'package:standmaster/router/organizer/router.dart';
import 'package:standmaster/router/auth/router.dart';
import 'package:standmaster/router/auth/routes.dart';
import 'package:standmaster/router/stand_holder/router.dart';
import 'package:standmaster/router/parent/router.dart';
import 'package:standmaster/router/child/router.dart';

class AppRouter {
  GoRouter goRouter(BuildContext context) {
    return GoRouter(
      initialLocation: AuthRoutes.signIn,
      refreshListenable: Provider.of<AuthProvider>(context, listen: false),
      redirect: (BuildContext context, GoRouterState state) {
        AuthUser user = Provider.of<AuthProvider>(context, listen: false).user;
        final bool isLogged =
            Provider.of<AuthProvider>(context, listen: false).isLogged;
        if (!isLogged && !state.fullPath!.startsWith("/auth")) {
          return AuthRoutes.signIn;
        }
        if (isLogged && state.fullPath!.startsWith("/auth")) {
          if (user.role == "ORGANIZER") {
            return OrganizerRoutes.userDetails;
          } else if (user.role == "STAND_HOLDER") {
            return StandHolderRoutes.userDetails;
          } else if (user.role == "PARENT") {
            return ParentRoutes.userDetails;
          } else if (user.role == "CHILD") {
            return ChildRoutes.userDetails;
          }
        }
        if (isLogged && user.role == "STAND_HOLDER" && !user.hasStand) {
          return StandHolderRoutes.standCreate;
        }
        if (isLogged &&
            user.role == "STAND_HOLDER" &&
            user.hasStand &&
            state.fullPath!.startsWith("/stand-holder/stand-create")) {
          return StandHolderRoutes.standDetails;
        }
        return state.fullPath;
      },
      routes: [
        ...AuthRouter.routes,
        OrganizerRouter.routes,
        StandHolderRouter.routes,
        ParentRouter.routes,
        ChildRouter.routes,
      ],
    );
  }
}
