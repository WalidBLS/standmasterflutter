import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StandHolderBottomNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const StandHolderBottomNavigation({
    super.key,
    required this.navigationShell,
  });

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: navigationShell.currentIndex,
        onTap: _goBranch,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.celebration),
            label: 'Kermesses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Stand',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
