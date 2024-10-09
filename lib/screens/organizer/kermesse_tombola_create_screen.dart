import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/services/tombola_service.dart';
import 'package:standmaster/widgets/screen.dart';

class KermesseTombolaCreateScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseTombolaCreateScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseTombolaCreateScreen> createState() =>
      _KermesseTombolaCreateScreenState();
}

class _KermesseTombolaCreateScreenState
    extends State<KermesseTombolaCreateScreen> {
  final TombolaService _tombolaService = TombolaService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _giftController = TextEditingController();

  Future<void> _submit() async {
    ApiResponse<Null> response = await _tombolaService.create(
      kermesseId: widget.kermesseId,
      name: _nameController.text,
      price: int.parse(_priceController.text),
      gift: _giftController.text,
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
          backgroundColor: Colors.redAccent, // Erreur en rouge
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tombola créée avec succès'),
          backgroundColor: Colors.green, // Succès en vert
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Créer une tombola"),
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
                labelText: 'Nom de la tombola',
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              _buildTextInput(
                labelText: 'Prix du billet',
                controller: _priceController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextInput(
                labelText: 'Cadeau à gagner',
                controller: _giftController,
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
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText, // Floating label
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _giftController.dispose();
    super.dispose();
  }
}
