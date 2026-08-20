import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen/homescreen.dart';
import '../screens/home_screen/widgets/CameraScreen.dart';
import '../screens/splashscreen.dart';

// The Router Configuration
final router = GoRouter(
  initialLocation: '/SplashScreen',
  routes: [
    // Splash Screen Route
    GoRoute(
      path: '/SplashScreen',
      builder: (context, state) => const AnimatedSplashScreen(),
    ),

    // Home Screen Route
    GoRoute(
      path: '/Homescreen',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/camera',
      builder: (context, state) => const CameraScreen(),
    ),
  ],
);