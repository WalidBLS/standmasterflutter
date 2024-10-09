import 'package:flutter/material.dart';
import 'package:standmaster/api/api_response.dart';
import 'package:standmaster/data/user_list_response.dart';
import 'package:standmaster/services/user_service.dart';

class ChildSelect extends StatefulWidget {
  final int defaultValue;
  final Function(int) onChange;

  const ChildSelect({
    super.key,
    required this.defaultValue,
    required this.onChange,
  });

  @override
  State<ChildSelect> createState() => _ChildSelectState();
}

class _ChildSelectState extends State<ChildSelect> {
  final UserService _userService = UserService();

  bool _isLoading = true;
  String _error = '';
  List<UserListItem> _items = [];

  Future<void> _getAll() async {
    ApiResponse<List<UserListItem>> response =
        await _userService.listChildren();
    if (response.error != null) {
      setState(() {
        _error = response.error!;
        _isLoading = false;
      });
    } else {
      setState(() {
        _items = response.data!;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getAll();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (_error.isNotEmpty) {
      return Center(
        child: Text(
          _error,
        ),
      );
    }
    return DropdownButton<String>(
      value: widget.defaultValue.toString(),
      onChanged: (String? newValue) {
        setState(() {
          widget.onChange(int.parse(newValue!));
        });
      },
      items: [
        const DropdownMenuItem(value: '0', child: Text('Select a child')),
        ..._items.map<DropdownMenuItem<String>>((UserListItem user) {
          return DropdownMenuItem<String>(
            value: user.id.toString(),
            child: Text(user.name),
          );
        })
      ],
    );
  }
}
