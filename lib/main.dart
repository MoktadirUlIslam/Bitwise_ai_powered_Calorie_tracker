import 'package:Bitwise/providers/firebase_options.dart';
import 'package:Bitwise/utlits/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      routerConfig: router,
    );
  }
}