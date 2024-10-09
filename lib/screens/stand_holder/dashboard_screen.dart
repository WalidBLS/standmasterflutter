import 'package:flutter/material.dart';
import 'package:standmaster/widgets/sign_out_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Stand Holder Dashboard',
            ),
          ],
        ),
      ),
    );
  }
}
