// lib/core/app_router.dart
import 'package:Bitwise/screens/Profile_screen/Profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/auth_connections/ForgotPasswordScreen.dart';
import '../screens/auth_connections/SignInScreen.dart';
import '../screens/auth_connections/SignUpScreen.dart';
import '../screens/auth_connections/provider/auth_provider.dart';
import '../screens/home_screen/homescreen.dart';
import '../screens/home_screen/widgets/CameraScreen.dart';
import '../screens/splashscreen.dart';

// ✅ Don't create instance here - use a getter or late initialization
AuthProvider? _authProvider;

AuthProvider get authProvider {
  _authProvider ??= AuthProvider();
  return _authProvider!;
}

// Redirect function to handle auth state
String? _handleRedirect(BuildContext context, GoRouterState state) {
  // ✅ Initialize auth provider if needed
  final auth = authProvider;
  final bool isAuthenticated = auth.isUserLoggedIn;
  final String location = state.matchedLocation;

  // 🔥 CRITICAL: If auth state is not yet determined, don't redirect
  // Let the splash screen handle the initial loading
  if (state.matchedLocation == '/SplashScreen') {
    // Always show splash screen first
    return null;
  }

  // List of auth routes (no authentication required)
  const authRoutes = ['/signin', '/signup', '/Forgetpassword', '/SplashScreen'];

  // List of protected routes (authentication required)
  const protectedRoutes = [
    '/Homescreen',
    '/camera',
    '/bmi',
    '/statistics',
    '/profile'
  ];

  // If user is logged in and trying to access auth screens
  if (isAuthenticated && authRoutes.contains(location)) {
    return '/Homescreen'; // Redirect to home
  }

  // If user is NOT authenticated and trying to access protected routes
  if (!isAuthenticated && protectedRoutes.contains(location)) {
    return '/signin'; // Redirect to sign in
  }

  // If on splash screen and authenticated, redirect to home
  if (isAuthenticated && location == '/SplashScreen') {
    return '/Homescreen';
  }

  // If on splash screen and not authenticated, go to signin
  if (!isAuthenticated && location == '/SplashScreen') {
    return '/signin';
  }

  // Otherwise, allow navigation
  return null;
}

final router = GoRouter(
  initialLocation: '/SplashScreen',
  redirect: _handleRedirect,
  routes: [
    // Splash Screen Route
    GoRoute(
      path: '/SplashScreen',
      builder: (context, state) => const AnimatedSplashScreen(),
    ),

    // Auth Routes
    GoRoute(
      path: '/signin',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpScreen(),
    ),

    // Forget password screen route
    GoRoute(
      path: '/Forgetpassword',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),

    // Home Screen Route (Protected)
    GoRoute(
      path: '/Homescreen',
      builder: (context, state) => const HomeScreen(),
    ),

    // Camera Route (Protected)
    GoRoute(
      path: '/camera',
      builder: (context, state) => const CameraScreen(),
    ),

    // BMI Calculator Route (Protected)
    GoRoute(
      path: '/bmi',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text("BMI Calculator Screen Placeholder")),
      ),
    ),

    // Statistics Route (Protected)
    GoRoute(
      path: '/statistics',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text("Statistics Screen Placeholder")),
      ),
    ),

    // Profile Route (Protected)
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);