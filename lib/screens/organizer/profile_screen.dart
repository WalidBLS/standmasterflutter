import 'package:flutter/material.dart';
import 'package:standmaster/widgets/screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Screen(
      child: Column(
        children: [
          Text(
            'Profile Organizer',
          ),
        ],
      ),
    );
  }
}
