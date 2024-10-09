import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_constants.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/providers/auth_provider.dart';
import 'package:standmaster/router/auth/routes.dart';
import 'package:standmaster/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserEditScreen extends StatefulWidget {
  final int userId;

  const UserEditScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final UserService _userService = UserService();

  Future<void> _submit() async {
    ApiResponse<Null> response = await _userService.edit(
      userId: widget.userId,
      password: _passwordController.text,
      newPassword: _newPasswordController.text,
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
          backgroundColor: Colors.redAccent,
        ),
      );
    } else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove(ApiConstants.tokenKey);
      Provider.of<AuthProvider>(context, listen: false)
          .setUser(-1, "", "", "", false);
      context.go(AuthRoutes.signIn);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mot de passe modifié avec succès'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Modifier le mot de passe',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildTextInput(
                labelText: 'Mot de passe actuel',
                controller: _passwordController,
                obscureText: true, // Masquer le texte
                icon: Icons.lock,
              ),
              const SizedBox(height: 16),
              _buildTextInput(
                labelText: 'Nouveau mot de passe',
                controller: _newPasswordController,
                obscureText: true, // Masquer le texte
                icon: Icons.lock_outline,
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
                  'Enregistrer',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput({
    required String labelText,
    required TextEditingController controller,
    bool obscureText = false,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText, // Pour les mots de passe
      decoration: InputDecoration(
        hintText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(icon),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
}
