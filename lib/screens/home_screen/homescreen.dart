import 'package:Bitwise/screens/home_screen/widgets/GreetingHeader.dart';
import 'package:Bitwise/screens/home_screen/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6EF),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    GreetingHeader(),
                    SizedBox(height: 20),
                    TodayCalorieCard(),
                    SizedBox(height: 20),
                    MiniMacroRow(),
                    SizedBox(height: 24),
                    RecentMealsHeader(),
                    SizedBox(height: 12),
                    MealHistoryList(),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            // Added extra transparent spacing to prevent tightness
            const SizedBox(height: 10),
            const CustomBottomNavBar(),
          ],
        ),
      ),
    );
  }
}