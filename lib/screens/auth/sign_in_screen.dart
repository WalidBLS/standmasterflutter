import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/router/child/routes.dart';
import 'package:standmaster/router/parent/routes.dart';
import 'package:standmaster/router/stand_holder/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/providers/auth_provider.dart';
import 'package:standmaster/router/organizer/routes.dart';
import 'package:standmaster/services/auth_service.dart';
import 'package:standmaster/data/sign_in_response.dart';
import 'package:standmaster/router/auth/routes.dart';
import 'package:standmaster/api/api_constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  Future<void> _submit() async {
    ApiResponse<SignInResponse> response = await _authService.signIn(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
        ),
      );
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString(
        ApiConstants.tokenKey,
        response.data!.token,
      );
      Provider.of<AuthProvider>(context, listen: false).setUser(
        response.data!.id,
        response.data!.name,
        response.data!.email,
        response.data!.role,
        response.data!.hasStand,
      );
      if (response.data!.role == "ORGANIZER") {
        context.go(OrganizerRoutes.userDetails);
      } else if (response.data!.role == "STAND_HOLDER") {
        context.go(StandHolderRoutes.userDetails);
      } else if (response.data!.role == "PARENT") {
        context.go(ParentRoutes.userDetails);
      } else if (response.data!.role == "CHILD") {
        context.go(ChildRoutes.userDetails);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connexion avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                const Text(
                  'Connexion',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    'assets/standmasterlogo.png',
                    height: 170,
                  ),
                ),

                const SizedBox(height: 40),  // Espace entre le logo et le texte


                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Mot de passe',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Connexion',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Pas encore inscrit ?"),
                    TextButton(
                      onPressed: () {
                        context.push(AuthRoutes.signUp);
                      },
                      child: const Text(
                        'Créer un compte',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
