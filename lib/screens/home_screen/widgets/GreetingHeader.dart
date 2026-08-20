import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../utlits/app_colors.dart';

// --- 1. GREETING HEADER ---
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Tuesday, 19 August",
          style: TextStyle(
            color: AppColors.backgroundDark.withOpacity(0.6),
            fontSize: 13,
            fontWeight: FontWeight.w500,
            fontFamily: 'Sora',
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "Good morning 👋",
          style: TextStyle(
            color: Color(0xFF1B211D), // "Ink" color
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontFamily: 'Fraunces',
          ),
        ),
      ],
    );
  }
}

// --- 2. TODAY CALORIE CARD ---
class TodayCalorieCard extends StatelessWidget {
  const TodayCalorieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 8)),
        ],
      ),
      child: Row(
        children: [
          // Custom Ring Widget
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withOpacity(0.15), width: 6),
                  ),
                ),
                const CustomProgressRing(progress: 0.64, color: AppColors.fruitOrange),
                // Bite mark cutout
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: AppColors.backgroundDark,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "1,340",
                style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700, fontFamily: 'JetBrains Mono'),
              ),
              const SizedBox(height: 2),
              Text(
                "of 2,100 kcal goal",
                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "760 kcal left today",
                  style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- 3. MINI MACROS ---
class MiniMacroRow extends StatelessWidget {
  const MiniMacroRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: MiniMacroItem(label: "Protein", grams: "82g", color: Color(0xFFD6584A), progress: 0.7)),
        SizedBox(width: 12),
        Expanded(child: MiniMacroItem(label: "Carbs", grams: "140g", color: AppColors.fruitOrange, progress: 0.55)),
        SizedBox(width: 12),
        Expanded(child: MiniMacroItem(label: "Fat", grams: "44g", color: AppColors.backgroundDark, progress: 0.38)),
      ],
    );
  }
}

class MiniMacroItem extends StatelessWidget {
  final String label;
  final String grams;
  final Color color;
  final double progress;

  const MiniMacroItem({
    super.key,
    required this.label,
    required this.grams,
    required this.color,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 32,
            height: 32,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: color.withOpacity(0.2), width: 3),
                  ),
                ),
                CustomProgressRing(progress: progress, color: color, strokeWidth: 3),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w600,
              color: AppColors.backgroundDark.withOpacity(0.5),
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            grams,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'JetBrains Mono'),
          ),
        ],
      ),
    );
  }
}

// --- 4. RECENT MEALS ---
class RecentMealsHeader extends StatelessWidget {
  const RecentMealsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Today's meals",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Fraunces'),
        ),
        Text(
          "See all",
          style: TextStyle(color: AppColors.backgroundDark, fontWeight: FontWeight.w600, fontSize: 13),
        ),
      ],
    );
  }
}

class MealHistoryList extends StatelessWidget {
  const MealHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        MealRow(
          name: "Salmon Bowl",
          time: "1:05 PM",
          kcal: "612",
          gradientColors: [Color(0xFFE7B15A), Color(0xFFC96B4A)],
        ),
        MealRow(
          name: "Greek Yogurt & Berries",
          time: "8:20 AM",
          kcal: "210",
          gradientColors: [Color(0xFFB7C88A), Color(0xFF6E8F5A)],
        ),
        MealRow(
          name: "Chicken Paratha Roll",
          time: "10:40 AM",
          kcal: "518",
          gradientColors: [Color(0xFFE0C08A), Color(0xFFB98E4E)],
          isLast: true,
        ),
      ],
    );
  }
}

class MealRow extends StatelessWidget {
  final String name;
  final String time;
  final String kcal;
  final List<Color> gradientColors;
  final bool isLast;

  const MealRow({
    super.key,
    required this.name,
    required this.time,
    required this.kcal,
    required this.gradientColors,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : Colors.black.withOpacity(0.06),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
              Text(time, style: TextStyle(fontSize: 11, color: AppColors.backgroundDark.withOpacity(0.5))),
            ],
          ),
          const Spacer(),
          Text(
            kcal,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: 'JetBrains Mono'),
          ),
        ],
      ),
    );
  }
}

// --- 5. CUSTOM PROGRESS RING HELPER ---
class CustomProgressRing extends StatelessWidget {
  final double progress;
  final Color color;
  final double strokeWidth;

  const CustomProgressRing({
    super.key,
    required this.progress,
    required this.color,
    this.strokeWidth = 6,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RingPainter(progress: progress, color: color, strokeWidth: strokeWidth),
      size: const Size(80, 80),
    );
  }
}

class RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  RingPainter({required this.progress, required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}