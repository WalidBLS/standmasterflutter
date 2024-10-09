import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:standmaster/app.dart';
import 'package:standmaster/providers/auth_provider.dart';
import 'package:standmaster/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: App(
        router: AppRouter(),
      ),
    ),
  );
}
