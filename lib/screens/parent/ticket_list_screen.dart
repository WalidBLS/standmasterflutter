import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/ticket_list_response.dart';
import 'package:standmaster/router/parent/routes.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Tickets',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple, // Couleur de la navbar
      ),
      body: ScreenList(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<TicketListItem>>(
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
                        child: Text('Aucun ticket trouvé'),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        TicketListItem item = snapshot.data![index];
                        return ListTile(
                          title: Text(item.isWinner ? 'Gagnant' : 'Perdant'),
                          subtitle: Text(item.user.name),
                          onTap: () {
                            context.push(
                              ParentRoutes.ticketDetails,
                              extra: {
                                "ticketId": item.id,
                              },
                            );
                          },
                        );
                      },
                    );
                  }
                  return const Center(
                    child: Text('Aucun ticket trouvé'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
