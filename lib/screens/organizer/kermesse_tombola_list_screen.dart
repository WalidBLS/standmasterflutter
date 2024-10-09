import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/tombola_list_response.dart';
import 'package:standmaster/router/organizer/routes.dart';
import 'package:standmaster/services/tombola_service.dart';
import 'package:standmaster/widgets/screen_list.dart';

class KermesseTombolaListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseTombolaListScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseTombolaListScreen> createState() =>
      _KermesseTombolaListScreenState();
}

class _KermesseTombolaListScreenState extends State<KermesseTombolaListScreen> {
  final Key _key = UniqueKey();

  final TombolaService _tombolaService = TombolaService();

  Future<List<TombolaListItem>> _getAll() async {
    ApiResponse<List<TombolaListItem>> response = await _tombolaService.list(
      kermesseId: widget.kermesseId,
    );
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
        title: const Text('Liste des Tombolas',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<TombolaListItem>>(
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
              // Si la liste des tombolas est vide
              if (snapshot.data!.isEmpty) {
                return const Center(child: Text('Aucune tombola trouvée'));
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  TombolaListItem item = snapshot.data![index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        item.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        item.gift,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.red),
                      onTap: () {
                        context.push(
                          OrganizerRoutes.kermesseTombolaDetails,
                          extra: {
                            "tombolaId": item.id,
                            "kermesseId": widget.kermesseId,
                          },
                        );
                      },
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('Aucune tombola trouvée'));
          },
        ),
      ),
      floatingActionButton: FutureBuilder<List<TombolaListItem>>(
        key: _key,
        future: _getAll(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isEmpty) {
            return FloatingActionButton(
              onPressed: () async {
                await context.push(
                  OrganizerRoutes.kermesseTombolaCreate,
                  extra: {"kermesseId": widget.kermesseId},
                );
                _refresh();
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.add,
                color: Colors.white,
              ),
            );
          } else {
            return Container(); // Pas de bouton si une tombola existe
          }
        },
      ),
    );
  }
}
