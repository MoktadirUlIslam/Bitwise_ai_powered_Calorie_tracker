import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // <-- IMPORT THIS
import '../../../utlits/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Home
            const NavIcon(icon: Icons.home_rounded, isActive: true),

            // 2. Camera FAB (Center) - CLICKABLE
            Transform.translate(
              offset: const Offset(0, -28),
              child: GestureDetector(
                onTap: () {
                  // Use GoRouter instead of Navigator.push
                  context.go('/camera');
                },
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.fruitOrange,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.fruitOrange.withOpacity(0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xFF1B211D),
                    size: 28,
                  ),
                ),
              ),
            ),

            // 3. Statistics
            const NavIcon(icon: Icons.bar_chart_rounded, isActive: false),
          ],
        ),
      ),
    );
  }
}

class NavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const NavIcon({super.key, required this.icon, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 32,
      color: isActive
          ? AppColors.backgroundDark
          : AppColors.backgroundDark.withOpacity(0.25),
    );
  }
}