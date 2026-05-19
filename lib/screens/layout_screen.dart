// lib/screens/layout_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'dashboard_screen.dart';
import 'schedule_screen.dart';
import 'location_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';
import '../widgets/bottom_nav.dart';
import '../providers/user_provider.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardScreen(),
    ScheduleScreen(),
    LocationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: KampusinBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        onLogout: () async {
          await context.read<UserProvider>().logout();
          if (context.mounted) {
            context.go('/login');
          }
        },
      ),
    );
  }
}
