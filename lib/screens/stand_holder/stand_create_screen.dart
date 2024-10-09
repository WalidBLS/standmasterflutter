import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/providers/auth_provider.dart';
import 'package:standmaster/router/stand_holder/routes.dart';
import 'package:standmaster/services/stand_service.dart';
import 'package:standmaster/widgets/stand_type_select.dart';
import 'package:provider/provider.dart';

class StandCreateScreen extends StatefulWidget {
  const StandCreateScreen({super.key});

  @override
  State<StandCreateScreen> createState() => _StandCreateScreenState();
}

class _StandCreateScreenState extends State<StandCreateScreen> {
  String _selectedType = "ACTIVITY";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  final StandService _standService = StandService();

  Future<void> _submit() async {
    ApiResponse<Null> response = await _standService.create(
      type: _selectedType,
      name: _nameController.text,
      description: _descriptionController.text,
      price: int.parse(_priceController.text),
      stock: int.parse(_stockController.text),
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
          backgroundColor: Colors.redAccent,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Stand créé avec succés'),
          backgroundColor: Colors.green,
        ),
      );
      Provider.of<AuthProvider>(context, listen: false).setHasStand(true);
      context.go(StandHolderRoutes.standDetails);
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
                'Créer un stand',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Veuillez sélectionner le type du stand :',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              StandTypeSelect(
                defaultValue: _selectedType,
                onChange: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildTextInput(
                labelText: 'Nom du stand',
                controller: _nameController,
              ),
              const SizedBox(height: 16),
              _buildTextInput(
                labelText: 'Description',
                controller: _descriptionController,
              ),
              const SizedBox(height: 16),
              _buildTextInput(
                labelText: 'Prix',
                controller: _priceController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextInput(
                labelText: 'Stock',
                controller: _stockController,
                keyboardType: TextInputType.number,
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
              const SizedBox(height: 16),
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
        hintText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: labelText == 'Nom du stand'
            ? const Icon(Icons.business)
            : labelText == 'Prix'
            ? const Icon(Icons.attach_money)
            : labelText == 'Stock'
            ? const Icon(Icons.inventory)
            : const Icon(Icons.description),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}
