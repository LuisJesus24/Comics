import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavigationScreen({super.key, required this.navigationShell});

  void onTap(int index) {
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
        currentIndex: navigationShell.currentIndex,

        onTap: onTap,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
