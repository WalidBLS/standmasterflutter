import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/user_list_response.dart';
import 'package:standmaster/router/parent/routes.dart';
import 'package:standmaster/services/user_service.dart';
import 'package:standmaster/widgets/screen_list.dart';

class ChildrenListScreen extends StatefulWidget {
  const ChildrenListScreen({
    super.key,
  });

  @override
  State<ChildrenListScreen> createState() => _ChildrenListScreenState();
}

class _ChildrenListScreenState extends State<ChildrenListScreen> {
  final Key _key = UniqueKey();

  final UserService _userService = UserService();

  Future<List<UserListItem>> _getAll() async {
    ApiResponse<List<UserListItem>> response = await _userService.listChildren();
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
        title: const Text('Liste d\'enfants',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push(ParentRoutes.childrenInvite);
          _refresh();
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add,
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
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.redAccent),
                ),
              );
            }
            if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('Vous n\'avez pas d\'enfant inscrit'),
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
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
                      onTap: () {
                        context.push(
                          ParentRoutes.childrenDetails,
                          extra: {"userId": item.id},
                        );
                      },
                    ),
                  );
                },
              );
            }
            return const Center(child: Text('Vous n\'avez pas d\'enfant'));
          },
        ),
      ),
    );
  }
}
