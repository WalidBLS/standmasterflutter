import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/tombola_details_response.dart';
import 'package:standmaster/services/tombola_service.dart';
import 'package:standmaster/widgets/screen.dart';

class KermesseTombolaEditScreen extends StatefulWidget {
  final int kermesseId;
  final int tombolaId;

  const KermesseTombolaEditScreen({
    super.key,
    required this.tombolaId,
    required this.kermesseId,
  });

  @override
  State<KermesseTombolaEditScreen> createState() =>
      _KermesseTombolaEditScreenState();
}

class _KermesseTombolaEditScreenState extends State<KermesseTombolaEditScreen> {
  final Key _key = UniqueKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _giftController = TextEditingController();

  final TombolaService _tombolaService = TombolaService();

  Future<TombolaDetailsResponse> _get() async {
    ApiResponse<TombolaDetailsResponse> response =
    await _tombolaService.details(
      tombolaId: widget.tombolaId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _submit() async {
    ApiResponse<Null> response = await _tombolaService.edit(
      id: widget.tombolaId,
      name: _nameController.text,
      price: int.parse(_priceController.text),
      gift: _giftController.text,
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
          content: Text('Tombola modifiée avec succès'),
          backgroundColor: Colors.green,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Même fond que d'autres écrans
      appBar: AppBar(
        title: const Text("Modifier la Tombola"),
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
              FutureBuilder<TombolaDetailsResponse>(
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
                    TombolaDetailsResponse data = snapshot.data!;
                    // Initialisation des champs avec les valeurs actuelles de la tombola
                    _nameController.text = data.name;
                    _priceController.text = data.price.toString();
                    _giftController.text = data.gift;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTextInput(
                          labelText: 'Nom de la Tombola',
                          controller: _nameController,
                        ),
                        const SizedBox(height: 16),
                        _buildTextInput(
                          labelText: 'Prix',
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 16),
                        _buildTextInput(
                          labelText: 'Cadeau',
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
        prefixIcon: labelText == 'Nom de la Tombola'
            ? const Icon(Icons.local_activity)
            : labelText == 'Prix'
            ? const Icon(Icons.attach_money)
            : const Icon(Icons.card_giftcard),
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
