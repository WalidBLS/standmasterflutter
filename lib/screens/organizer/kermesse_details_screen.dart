import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/kermesse_details_response.dart';
import 'package:standmaster/router/organizer/routes.dart';
import 'package:standmaster/services/kermesse_service.dart';

class KermesseDetailsScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseDetailsScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseDetailsScreen> createState() => _KermesseDetailsScreenState();
}

class _KermesseDetailsScreenState extends State<KermesseDetailsScreen> {
  final Key _key = UniqueKey();

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

  Future<void> _end() async {
    ApiResponse<Null> response =
    await _kermesseService.end(id: widget.kermesseId);
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kermesse terminée avec succès'),
        ),
      );
      _refresh();
    }
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
          'Détails de la Kermesse',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<KermesseDetailsResponse>(
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
              KermesseDetailsResponse data = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Carte principale avec les informations de la kermesse
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
                            'Nom: ${data.name}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 8),
                          Text(
                            'Description: ${data.description}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Statut: ${data.status == "STARTED" ? "En cours" : "Terminée"}',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: data.status == "STARTED"
                                  ? Colors.green
                                  : Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Cartes interactives pour les actions
                  _buildActionCard(
                    icon: Icons.edit,
                    label: 'Modifier la Kermesse',
                    onTap: () async {
                      await context.push(
                        OrganizerRoutes.kermesseEdit,
                        extra: {
                          "kermesseId": data.id,
                        },
                      );
                      _refresh();
                    },
                  ),

                  if (data.status == "STARTED") ...[
                    const SizedBox(height: 16),
                    _buildActionCard(
                      icon: Icons.stop_circle_outlined,
                      label: 'Terminer la Kermesse',
                      color: Colors.redAccent,
                      onTap: _end,
                    ),
                  ],

                  const SizedBox(height: 16),
                  _buildActionCard(
                    icon: Icons.people,
                    label: 'Voir les Utilisateurs',
                    onTap: () {
                      context.push(
                        OrganizerRoutes.kermesseUserList,
                        extra: {
                          "kermesseId": data.id,
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildActionCard(
                    icon: Icons.store,
                    label: 'Voir les Stands',
                    onTap: () {
                      context.push(
                        OrganizerRoutes.kermesseStandList,
                        extra: {
                          "kermesseId": data.id,
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildActionCard(
                    icon: Icons.card_giftcard,
                    label: 'Voir les Tombolas',
                    onTap: () {
                      context.push(
                        OrganizerRoutes.kermesseTombolaList,
                        extra: {
                          "kermesseId": data.id,
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildActionCard(
                    icon: Icons.chat_bubble_outline,
                    label: 'Voir les Interactions',
                    onTap: () {
                      context.push(
                        OrganizerRoutes.kermesseInteractionList,
                        extra: {
                          "kermesseId": data.id,
                        },
                      );
                    },
                  ),
                ],
              );
            }
            return const Center(child: Text('Une erreur est survenue'));
          },
        ),
      ),
    );
  }

  // Fonction pour construire une carte d'action
  Widget _buildActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color color = Colors.blueAccent,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          child: Row(
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
