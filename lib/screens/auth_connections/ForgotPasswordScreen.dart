import 'package:Bitwise/screens/auth_connections/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../utlits/app_colors.dart';
import '../../utlits/snackbar_helper.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isEmailSent = false;
  bool _emailExists = false;
  bool _isEmailChecked = false;
  final AuthProvider _authProvider = AuthProvider();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Step 1: Check if email exists
  Future<void> _checkEmail() async {
    final String email = _emailController.text.trim();

    // Validate email
    if (email.isEmpty) {
      SnackBarHelper.showErrorSnackBar(
        'Please enter your email address',
        title: 'Validation Error',
      );
      return;
    }

    // Validate email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      SnackBarHelper.showErrorSnackBar(
        'Please enter a valid email address',
        title: 'Invalid Email',
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Check if email exists in Firestore
      final bool exists = await _authProvider.checkEmailExists(email);

      setState(() {
        _isLoading = false;
        _emailExists = exists;
        _isEmailChecked = true;
      });

      // Show result to user
      if (mounted) {
        if (exists) {
          // Email found - show success and send reset link
          SnackBarHelper.showSuccessSnackBar(
            'Email found! Sending reset link...',
            title: 'Email Verified',
            duration: const Duration(seconds: 2),
          );

          // Step 2: Send password reset link
          await _sendResetLink(email);
        } else {
          // Email not found
          SnackBarHelper.showErrorSnackBar(
            'No account found with this email address',
            title: 'Not Found',
            duration: const Duration(seconds: 3),
          );
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        SnackBarHelper.showErrorSnackBar(
          e.toString(),
          title: 'Error',
        );
      }
    }
  }

  // Step 2: Send reset link (only called if email exists)
  Future<void> _sendResetLink(String email) async {
    try {
      // Send password reset email
      await _authProvider.sendPasswordResetEmail(email: email);

      if (mounted) {
        setState(() {
          _isEmailSent = true;
        });

        SnackBarHelper.showSuccessSnackBar(
          'Password reset link sent to your email!',
          title: 'Email Sent',
          duration: const Duration(seconds: 4),
        );
      }
    } catch (e) {
      if (mounted) {
        SnackBarHelper.showErrorSnackBar(
          'Failed to send reset link: ${e.toString()}',
          title: 'Error',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                // Back Button
                IconButton(
                  onPressed: () => context.go('/signin'),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                ),
                const SizedBox(height: 20),
                // Title
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter your email to receive a password reset link',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.7),
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 40),

                // Email Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _isEmailChecked
                          ? (_emailExists ? Colors.green : Colors.red)
                          : Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    enabled: !_isEmailSent,
                    decoration: InputDecoration(
                      hintText: 'Email Address',
                      hintStyle: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: _isEmailChecked
                            ? (_emailExists ? Colors.green : Colors.red)
                            : Colors.white.withOpacity(0.5),
                      ),
                      suffixIcon: _isEmailChecked
                          ? Icon(
                        _emailExists
                            ? Icons.check_circle
                            : Icons.error,
                        color: _emailExists ? Colors.green : Colors.red,
                      )
                          : null,
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),

                // Status Message
                if (_isEmailChecked) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: _emailExists
                          ? Colors.green.withOpacity(0.2)
                          : Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _emailExists
                            ? Colors.green.withOpacity(0.3)
                            : Colors.red.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _emailExists
                              ? Icons.check_circle_outline
                              : Icons.error_outline,
                          color: _emailExists ? Colors.green : Colors.red,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _emailExists
                                ? '✅ Email found! Reset link will be sent.'
                                : '❌ No account found with this email address.',
                            style: TextStyle(
                              color: _emailExists ? Colors.green : Colors.red,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 30),

                // Reset Button - Dynamic based on state
                if (!_isEmailSent)
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading || _isEmailSent
                          ? null
                          : _checkEmail,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.fruitOrange,
                        foregroundColor: AppColors.backgroundDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: AppColors.backgroundDark,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        'Check Email',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/signin');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.fruitOrange,
                        foregroundColor: AppColors.backgroundDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: AppColors.backgroundDark,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          // 🔥 FIX: Changed text to be shorter
                          const Text(
                            'Email Sent!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Additional Info
                if (_isEmailSent) ...[
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.white.withOpacity(0.7),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Check your email inbox and spam folder for the reset link',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}