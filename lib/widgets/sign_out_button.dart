import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:standmaster/router/auth/routes.dart';
import 'package:standmaster/providers/auth_provider.dart';
import 'package:standmaster/api/api_constants.dart';

class SignOutButton extends StatefulWidget {
  const SignOutButton({super.key});

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  Future<void> _signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(ApiConstants.tokenKey);
    Provider.of<AuthProvider>(context, listen: false)
        .setUser(-1, "", "", "", false);
    context.go(AuthRoutes.signIn);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Déconnecté avec succès"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _signOut,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        "Déconnexion",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
