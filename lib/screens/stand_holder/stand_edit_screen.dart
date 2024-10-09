import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/stand_details_response.dart';
import 'package:standmaster/services/stand_service.dart';
import 'package:standmaster/widgets/screen.dart';

class StandEditScreen extends StatefulWidget {
  const StandEditScreen({super.key});

  @override
  State<StandEditScreen> createState() => _StandEditScreenState();
}

class _StandEditScreenState extends State<StandEditScreen> {
  final Key _key = UniqueKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  final StandService _standService = StandService();

  Future<StandDetailsResponse> _get() async {
    ApiResponse<StandDetailsResponse> response = await _standService.current();
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _submit() async {
    ApiResponse<Null> response = await _standService.edit(
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
          content: Text('Stand modifié avec succès'),
          backgroundColor: Colors.green,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Fond similaire à l'écran de connexion
      appBar: AppBar(
        title: const Text("Modifier le stand"),
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
              const SizedBox(height: 40),
              const SizedBox(height: 20),
              FutureBuilder<StandDetailsResponse>(
                key: _key,
                future: _get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    StandDetailsResponse data = snapshot.data!;
                    // Initialisation des champs avec les valeurs actuelles du stand
                    _nameController.text = data.name;
                    _descriptionController.text = data.description;
                    _priceController.text = data.price.toString();
                    _stockController.text = data.stock.toString();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                      ],
                    );
                  }
                  return const Center(
                    child: Text('Erreur inattendue'),
                  );
                },
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
        labelText: labelText, // Ceci est le floating label
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
