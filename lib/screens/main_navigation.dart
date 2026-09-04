import 'package:flutter/material.dart';

import '../app/theme.dart';
import 'home_screen.dart';
import 'scan_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

 late final List<Widget> _screens = [
  HomeScreen(
    onScan: () => _changeTab(1),
  ),
  const ScanScreen(),
  const RiskMapScreen(),
  const HistoryScreen(),
];

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      // This navigation bar belongs to the entire app shell.
      // It stays visible while switching between the main tabs.
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,

        onDestinationSelected: _changeTab,

        backgroundColor: CropGuardColors.surface,

        indicatorColor: CropGuardColors.secondary.withValues(
          alpha: 0.15,
        ),

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(Icons.camera_alt_outlined),
            selectedIcon: Icon(Icons.camera_alt),
            label: 'Scan',
          ),

          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map),
            label: 'Map',
          ),

          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}


// ------------------------------------------------------------
// Temporary Map screen
// ------------------------------------------------------------

class RiskMapScreen extends StatelessWidget {
  const RiskMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Risk Map'),
      ),
      body: const Center(
        child: Text('Risk Map'),
      ),
    );
  }
}


// ------------------------------------------------------------
// Temporary History screen
// ------------------------------------------------------------

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan History'),
      ),
      body: const Center(
        child: Text('Scan History'),
      ),
    );
  }
}