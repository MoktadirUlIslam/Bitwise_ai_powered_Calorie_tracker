// lib/utils/snackbar_helper.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class SnackBarHelper {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  // Show error snackbar
  static void showErrorSnackBar(
      String message, {
        String title = "Error",
        Duration duration = const Duration(seconds: 3),
      }) {
    final context = scaffoldMessengerKey.currentContext;
    if (context == null) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final margin = screenWidth >= 600
        ? const EdgeInsets.symmetric(horizontal: 200, vertical: 20)
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 10);

    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.snackbarError,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        margin: margin,
        duration: duration,
        elevation: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        animation: CurvedAnimation(
          parent: const AlwaysStoppedAnimation(1.0),
          curve: Curves.easeInOut,
        ),
        action: SnackBarAction(
          label: '✕',
          textColor: Colors.white,
          onPressed: () {
            scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // Show success snackbar
  static void showSuccessSnackBar(
      String message, {
        String title = "Success",
        Duration duration = const Duration(seconds: 3),
      }) {
    final context = scaffoldMessengerKey.currentContext;
    if (context == null) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final margin = screenWidth >= 600
        ? const EdgeInsets.symmetric(horizontal: 200, vertical: 20)
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 10);

    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle_outline,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.snackbarSuccess,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        margin: margin,
        duration: duration,
        elevation: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        animation: CurvedAnimation(
          parent: const AlwaysStoppedAnimation(1.0),
          curve: Curves.easeInOut,
        ),
        action: SnackBarAction(
          label: '✕',
          textColor: Colors.white,
          onPressed: () {
            scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // Show info snackbar
  static void showInfoSnackBar(
      String message, {
        String title = "Info",
        Duration duration = const Duration(seconds: 3),
      }) {
    final context = scaffoldMessengerKey.currentContext;
    if (context == null) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final margin = screenWidth >= 600
        ? const EdgeInsets.symmetric(horizontal: 200, vertical: 20)
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 10);

    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.info_outline,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.snackbarInfo,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        margin: margin,
        duration: duration,
        elevation: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        animation: CurvedAnimation(
          parent: const AlwaysStoppedAnimation(1.0),
          curve: Curves.easeInOut,
        ),
        action: SnackBarAction(
          label: '✕',
          textColor: Colors.white,
          onPressed: () {
            scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // Show warning snackbar
  static void showWarningSnackBar(
      String message, {
        String title = "Warning",
        Duration duration = const Duration(seconds: 3),
      }) {
    final context = scaffoldMessengerKey.currentContext;
    if (context == null) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final margin = screenWidth >= 600
        ? const EdgeInsets.symmetric(horizontal: 200, vertical: 20)
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 10);

    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.warning_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textDark,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textDark.withOpacity(0.9),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.fruitOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        margin: margin,
        duration: duration,
        elevation: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        animation: CurvedAnimation(
          parent: const AlwaysStoppedAnimation(1.0),
          curve: Curves.easeInOut,
        ),
        action: SnackBarAction(
          label: '✕',
          textColor: AppColors.textDark,
          onPressed: () {
            scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // Show custom snackbar with AppColors
  static void showCustomSnackBar({
    required String message,
    required Color backgroundColor,
    required IconData icon,
    Color iconColor = Colors.white,
    String title = "",
    Duration duration = const Duration(seconds: 3),
  }) {
    final context = scaffoldMessengerKey.currentContext;
    if (context == null) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final margin = screenWidth >= 600
        ? const EdgeInsets.symmetric(horizontal: 200, vertical: 20)
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 10);

    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title.isNotEmpty)
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: backgroundColor == AppColors.fruitOrange
                            ? AppColors.textDark
                            : Colors.white,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  if (title.isNotEmpty) const SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      color: backgroundColor == AppColors.fruitOrange
                          ? AppColors.textDark.withOpacity(0.9)
                          : Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        margin: margin,
        duration: duration,
        elevation: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        animation: CurvedAnimation(
          parent: const AlwaysStoppedAnimation(1.0),
          curve: Curves.easeInOut,
        ),
        action: SnackBarAction(
          label: '✕',
          textColor: backgroundColor == AppColors.fruitOrange
              ? AppColors.textDark
              : Colors.white,
          onPressed: () {
            scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // Show themed snackbar using AppColors
  static void showThemedSnackBar({
    required String message,
    required SnackBarType type,
    String title = "",
    Duration duration = const Duration(seconds: 3),
  }) {
    switch (type) {
      case SnackBarType.success:
        showSuccessSnackBar(message, title: title, duration: duration);
        break;
      case SnackBarType.error:
        showErrorSnackBar(message, title: title, duration: duration);
        break;
      case SnackBarType.warning:
        showWarningSnackBar(message, title: title, duration: duration);
        break;
      case SnackBarType.info:
        showInfoSnackBar(message, title: title, duration: duration);
        break;
    }
  }

  // Show snackbar with fruit orange theme
  static void showOrangeSnackBar(
      String message, {
        String title = "Notice",
        Duration duration = const Duration(seconds: 3),
      }) {
    final context = scaffoldMessengerKey.currentContext;
    if (context == null) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final margin = screenWidth >= 600
        ? const EdgeInsets.symmetric(horizontal: 200, vertical: 20)
        : const EdgeInsets.symmetric(horizontal: 16, vertical: 10);

    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.textDark.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_active,
                color: AppColors.textDark,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textDark,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textDark.withOpacity(0.9),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.fruitOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        margin: margin,
        duration: duration,
        elevation: 8,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        animation: CurvedAnimation(
          parent: const AlwaysStoppedAnimation(1.0),
          curve: Curves.easeInOut,
        ),
        action: SnackBarAction(
          label: '✕',
          textColor: AppColors.textDark,
          onPressed: () {
            scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}

// Enum for snackbar types
enum SnackBarType {
  success,
  error,
  warning,
  info,
}