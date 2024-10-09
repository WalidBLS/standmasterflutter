import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/kermesse_list_response.dart';
import 'package:standmaster/router/organizer/routes.dart';
import 'package:standmaster/services/kermesse_service.dart';

class KermesseListScreen extends StatefulWidget {
  const KermesseListScreen({super.key});

  @override
  State<KermesseListScreen> createState() => _KermesseListScreenState();
}

class _KermesseListScreenState extends State<KermesseListScreen> {
  final Key _key = UniqueKey();

  final KermesseService _kermesseService = KermesseService();

  Future<List<KermesseListItem>> _getAll() async {
    ApiResponse<List<KermesseListItem>> response = await _kermesseService.list();
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
        title: const Text('Liste des Kermesses',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push(OrganizerRoutes.kermesseCreate);
          _refresh();
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add,
          color: Colors.white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<KermesseListItem>>(
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
                  style: TextStyle(color: Colors.redAccent),
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Pas de kermess trouvée'),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  KermesseListItem item = snapshot.data![index];
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
                        item.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
                      onTap: () {
                        context.push(
                          OrganizerRoutes.kermesseDetails,
                          extra: {"kermesseId": item.id},
                        );
                      },
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('Pas de kermess trouvée'));
          },
        ),
      ),
    );
  }
}
