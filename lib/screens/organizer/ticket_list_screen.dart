import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/ticket_list_response.dart';
import 'package:standmaster/router/organizer/routes.dart';
import 'package:standmaster/services/ticket_service.dart';
import 'package:standmaster/widgets/screen_list.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  final Key _key = UniqueKey();

  final TicketService _ticketService = TicketService();

  Future<List<TicketListItem>> _getAll() async {
    ApiResponse<List<TicketListItem>> response = await _ticketService.list();
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
        title: const Text('Liste des tickets',
          style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<TicketListItem>>(
          key: _key,
          future: _getAll(),
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
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Aucun ticket trouvé'),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  TicketListItem item = snapshot.data![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        item.isWinner ? 'Gagnant' : 'Perdant',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: item.isWinner ? Colors.green : Colors.grey,
                        ),
                      ),
                      subtitle: Text(
                        item.user.name,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: item.isWinner ? Colors.green : Colors.grey,
                      ),
                      onTap: () {
                        context.push(
                          OrganizerRoutes.ticketDetails,
                          extra: {"ticketId": item.id},
                        );
                      },
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('Aucun ticket trouvé'));
          },
        ),
      ),
    );
  }
}
