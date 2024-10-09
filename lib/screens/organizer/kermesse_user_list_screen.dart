import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/user_list_response.dart';
import 'package:standmaster/router/organizer/routes.dart';
import 'package:standmaster/services/user_service.dart';
import 'package:standmaster/widgets/screen_list.dart';

class KermesseUserListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseUserListScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseUserListScreen> createState() => _KermesseUserListScreenState();
}

class _KermesseUserListScreenState extends State<KermesseUserListScreen> {
  final Key _key = UniqueKey();

  final UserService _userService = UserService();

  Future<List<UserListItem>> _getAll() async {
    ApiResponse<List<UserListItem>> response = await _userService.list(
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
        title: const Text('Liste des participants',
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
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push(
            OrganizerRoutes.kermesseUserInvite,
            extra: {
              'kermesseId': widget.kermesseId,
            },
          );
          _refresh();
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.person_add,
        color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<UserListItem>>(
          key: _key,
          future: _getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Erreur : ${snapshot.error}',
                  style: TextStyle(color: Colors.redAccent),
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Aucun utilisateur trouvé'),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  UserListItem item = snapshot.data![index];
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
                        item.role,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('Aucun utilisateur trouvé'));
          },
        ),
      ),
    );
  }
}
