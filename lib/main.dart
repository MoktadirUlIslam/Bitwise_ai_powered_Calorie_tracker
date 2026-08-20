import 'package:Bitwise/utlits/app_colors.dart';
import 'package:flutter/material.dart';
import 'core/app_router.dart'; // <-- Import the NEW app_router.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bitwise',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        textTheme: const TextTheme(
          displayLarge: TextStyle(color: AppColors.leafGreen),
          bodyLarge: TextStyle(color: Colors.white70),
        ),
      ),
      // FIX: Use routerConfig with go_router.
      // This removes all the generic type errors permanently.
      routerConfig: router,
    );
  }
}