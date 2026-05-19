// lib/widgets/bottom_nav.dart

import 'package:flutter/material.dart';
import '../constants/app_theme.dart';

class KampusinBottomNav extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;
  final VoidCallback? onLogout;

  const KampusinBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      _NavItem(icon: Icons.grid_view_rounded, label: 'Home'),
      _NavItem(icon: Icons.calendar_today_rounded, label: 'Schedule'),
      _NavItem(icon: Icons.location_on_rounded, label: 'Location'),
      _NavItem(icon: Icons.person_rounded, label: 'Profile'),
      _NavItem(icon: Icons.logout_rounded, label: 'Logout'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkBlue,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isActive = currentIndex == index;
              final isLogout = index == items.length - 1;

              return GestureDetector(
                onTap: () {
                  if (isLogout) {
                    onLogout?.call();
                  } else {
                    onTap(index);
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  transform: isActive && !isLogout
                      ? (Matrix4.identity()..translate(0.0, -4.0))
                      : Matrix4.identity(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isActive && !isLogout
                              ? AppColors.primaryContainer
                              : isLogout
                                  ? Colors.red
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          items[index].icon,
                          size: 24,
                          color: isLogout || (isActive && !isLogout)
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index].label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: isLogout
                              ? Colors.red
                              : isActive
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  _NavItem({required this.icon, required this.label});
}
