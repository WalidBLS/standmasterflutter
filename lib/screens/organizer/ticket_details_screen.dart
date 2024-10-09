import 'package:flutter/material.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/ticket_details_response.dart';
import 'package:standmaster/services/ticket_service.dart';

class TicketDetailsScreen extends StatefulWidget {
  final int ticketId;

  const TicketDetailsScreen({
    super.key,
    required this.ticketId,
  });

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  final Key _key = UniqueKey();

  final TicketService _ticketService = TicketService();

  Future<TicketDetailsResponse> _get() async {
    ApiResponse<TicketDetailsResponse> response = await _ticketService.details(
      ticketId: widget.ticketId,
    );
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Détails du Ticket',
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
        child: FutureBuilder<TicketDetailsResponse>(
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
                  style: TextStyle(color: Colors.redAccent),
                ),
              );
            }
            if (snapshot.hasData) {
              TicketDetailsResponse data = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Carte principale avec les informations du ticket
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
                            'Statut: ${data.isWinner ? "Gagnant" : "Perdant"}',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: data.isWinner ? Colors.green : Colors.redAccent,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Utilisateur: ${data.user.name}',
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tombola: ${data.tombola.name}',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
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
}
