import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/services/stripe_service.dart';

class UserCreditEditScreen extends StatefulWidget {
  final int userId;

  const UserCreditEditScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserCreditEditScreen> createState() => _UserCreditEditScreenState();
}

class _UserCreditEditScreenState extends State<UserCreditEditScreen> {
  final TextEditingController _creditController = TextEditingController();
  final StripeService _stripeService = StripeService();

  Future<void> _submit() async {
    await _stripeService.stripePaymentCheckout(
      widget.userId,
      int.parse(_creditController.text),
      context,
      onSuccess: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Jetons achetés avec succès'),
          ),
        );
        context.pop();
      },
      onCancel: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Achat de jetons annulé'),
          ),
        );
      },
      onError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de l\'achat de jetons'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Acheter des jetons"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              _buildTextInput(
                labelText: 'Nombre de jetons à acheter',
                controller: _creditController,
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
                  'Acheter',
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
    bool isMultiline = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _creditController.dispose();
    super.dispose();
  }
}
