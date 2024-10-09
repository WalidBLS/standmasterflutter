import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/interaction_list_response.dart';
import 'package:standmaster/router/organizer/routes.dart';
import 'package:standmaster/services/interaction_service.dart';
import 'package:standmaster/widgets/screen_list.dart';

class KermesseInteractionListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseInteractionListScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseInteractionListScreen> createState() =>
      _KermesseInteractionListScreenState();
}

class _KermesseInteractionListScreenState
    extends State<KermesseInteractionListScreen> {
  final Key _key = UniqueKey();
  final InteractionService _interactionService = InteractionService();

  Future<List<InteractionListItem>> _getAll() async {
    ApiResponse<List<InteractionListItem>> response =
    await _interactionService.list(
      kermesseId: widget.kermesseId,
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
        title: const Text('Interactions Kermesse',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<InteractionListItem>>(
          key: _key,
          future: _getAll(),
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
                  style: TextStyle(color: Colors.redAccent),
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Aucune interaction trouvée'),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  InteractionListItem item = snapshot.data![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        item.user.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Crédits : ${item.credit}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
                      onTap: () async {
                        await context.push(
                          OrganizerRoutes.kermesseInteractionDetails,
                          extra: {
                            "kermesseId": widget.kermesseId,
                            "interactionId": item.id,
                          },
                        );
                      },
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('Aucune interaction trouvée'));
          },
        ),
      ),
    );
  }
}
