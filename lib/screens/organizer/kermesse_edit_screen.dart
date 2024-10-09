import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/kermesse_details_response.dart';
import 'package:standmaster/services/kermesse_service.dart';
import 'package:standmaster/widgets/screen.dart';

class KermesseEditScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseEditScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseEditScreen> createState() => _KermesseEditScreenState();
}

class _KermesseEditScreenState extends State<KermesseEditScreen> {
  final Key _key = UniqueKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final KermesseService _kermesseService = KermesseService();

  Future<KermesseDetailsResponse> _get() async {
    ApiResponse<KermesseDetailsResponse> response =
    await _kermesseService.details(
      kermesseId: widget.kermesseId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _submit() async {
    ApiResponse<Null> response = await _kermesseService.edit(
      id: widget.kermesseId,
      name: _nameController.text,
      description: _descriptionController.text,
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
          content: Text('Kermesse modifiée avec succès'),
          backgroundColor: Colors.green,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100], // Fond similaire à l'écran de connexion
      appBar: AppBar(
        title: const Text("Modifier la kermesse"),
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
              FutureBuilder<KermesseDetailsResponse>(
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
                    KermesseDetailsResponse data = snapshot.data!;
                    _nameController.text = data.name;
                    _descriptionController.text = data.description;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildTextInput(
                          labelText: 'Nom de la kermesse',
                          controller: _nameController,
                        ),
                        const SizedBox(height: 16),
                        _buildTextInput(
                          labelText: 'Description',
                          controller: _descriptionController,
                          isMultiline: true, // Champ multiligne
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
    bool isMultiline = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType:
      isMultiline ? TextInputType.multiline : TextInputType.text,
      maxLines: isMultiline ? null : 1, // Champ multiligne si nécessaire
      decoration: InputDecoration(
        labelText: labelText, // Label flottant
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
