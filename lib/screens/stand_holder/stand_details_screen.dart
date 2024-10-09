import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/stand_details_response.dart';
import 'package:standmaster/router/stand_holder/routes.dart';
import 'package:standmaster/services/stand_service.dart';
import 'package:standmaster/widgets/screen.dart';

class StandDetailsScreen extends StatefulWidget {
  const StandDetailsScreen({
    super.key,
  });

  @override
  State<StandDetailsScreen> createState() => _StandDetailsScreenState();
}

class _StandDetailsScreenState extends State<StandDetailsScreen> {
  final Key _key = UniqueKey();

  final StandService _standService = StandService();

  Future<StandDetailsResponse> _get() async {
    ApiResponse<StandDetailsResponse> response = await _standService.current();
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Détails du Stand',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<StandDetailsResponse>(
          key: _key,
          future: _get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${data.name}',
                                    style: theme.textTheme.bodyLarge?.copyWith(fontSize: 22),
                                  ),
                                  const SizedBox(height: 8),
                                  const Divider(),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Type: ${data.type}',
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Description: ${data.description}',
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Stock: ${data.stock}',
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Prix: ${data.price}',
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Bouton d'action pour modifier le stand, placé en bas de la page
                  ElevatedButton(
                    onPressed: () async {
                      await context.push(
                        StandHolderRoutes.standEdit,
                      );
                      _refresh();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Modifier',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              );
            }
            return const Center(
              child: Text('Une erreur est survenue'),
            );
          },
        ),
      ),
    );
  }
}
