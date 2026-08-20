import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../utlits/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Outer container is completely transparent, only holds the spacing
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 12),
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
            GestureDetector(
              onTap: () {
                if (currentIndex != 0) context.go('/Homescreen');
              },
              child: NavIcon(
                icon: Icons.home_rounded,
                isActive: currentIndex == 0,
              ),
            ),

            // 2. BMI
            GestureDetector(
              onTap: () {
                if (currentIndex != 1) context.go('/bmi');
              },
              child: NavIcon(
                icon: Icons.monitor_heart_outlined,
                isActive: currentIndex == 1,
              ),
            ),

            // 3. Camera FAB
            Transform.translate(
              offset: const Offset(0, -28),
              child: GestureDetector(
                onTap: () => context.go('/camera'),
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

            // 4. Statistics
            GestureDetector(
              onTap: () {
                if (currentIndex != 3) context.go('/statistics');
              },
              child: NavIcon(
                icon: Icons.bar_chart_rounded,
                isActive: currentIndex == 3,
              ),
            ),

            // 5. Profile
            GestureDetector(
              onTap: () {
                if (currentIndex != 4) context.go('/profile');
              },
              child: NavIcon(
                icon: Icons.person_rounded,
                isActive: currentIndex == 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const NavIcon({
    super.key,
    required this.icon,
    this.isActive = false,
  });

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