import 'package:flutter/material.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/user_list_response.dart';
import 'package:standmaster/services/kermesse_service.dart';
import 'package:standmaster/services/user_service.dart';
import 'package:standmaster/widgets/screen_list.dart';

class KermesseUserInviteScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseUserInviteScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseUserInviteScreen> createState() =>
      _KermesseUserInviteScreenState();
}

class _KermesseUserInviteScreenState extends State<KermesseUserInviteScreen> {
  final Key _key = UniqueKey();

  final UserService _userService = UserService();
  final KermesseService _kermesseService = KermesseService();

  Future<List<UserListItem>> _getAll() async {
    ApiResponse<List<UserListItem>> response =
        await _userService.listInviteKermesse(kermesseId: widget.kermesseId);
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _invite(int userId) async {
    ApiResponse<Null> response = await _kermesseService.inviteUser(
      kermesseId: widget.kermesseId,
      userId: userId,
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User invited successfully'),
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
    return ScreenList(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Kermesse User Invite",
          ),
          Expanded(
            child: FutureBuilder<List<UserListItem>>(
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
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      UserListItem item = snapshot.data![index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.email),
                        leading: ElevatedButton(
                          onPressed: () async {
                            await _invite(item.id);
                          },
                          child: const Text('Invite'),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: Text('No users found'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
