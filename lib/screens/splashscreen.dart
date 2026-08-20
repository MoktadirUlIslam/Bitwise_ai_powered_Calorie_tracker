import 'package:flutter/material.dart';
import '../utlits/app_colors.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import '../screens/auth_connections/provider/auth_provider.dart'; // Add this import

class AnimatedSplashScreen extends StatefulWidget {
  const AnimatedSplashScreen({super.key});

  @override
  State<AnimatedSplashScreen> createState() => _AnimatedSplashScreenState();
}

class _AnimatedSplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bgFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _orangeFadeAnimation;
  late Animation<double> _leafSlideAnimation;
  late Animation<double> _darkCircleScaleAnimation;
  late Animation<double> _minuteHandAnimation;

  // State for the typing text
  final ValueNotifier<bool> _startTyping = ValueNotifier<bool>(false);

  // Auth Provider instance
  final AuthProvider _authProvider = AuthProvider();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    _bgFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeIn)),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.8, curve: Curves.easeOutBack)),
    );

    _orangeFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.4, curve: Curves.easeIn)),
    );

    _leafSlideAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 0.7, curve: Curves.easeOutCubic)),
    );

    _darkCircleScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.6, 0.9, curve: Curves.easeOutBack)),
    );

    _minuteHandAnimation = Tween<double>(begin: 0.0, end: 2.1425).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.65, 0.95, curve: Curves.easeOutCubic)),
    );

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Trigger the typing animation after the logo is fully assembled
        _startTyping.value = true;

        // Wait for typing animation to finish, then check auth
        Future.delayed(const Duration(milliseconds: 3000), () {
          _checkAuthAndNavigate();
        });
      }
    });
  }

  Future<void> _checkAuthAndNavigate() async {
    if (!mounted) return;

    // Check if user is already logged in
    final bool isAuthenticated = _authProvider.isUserLoggedIn;

    // Navigate based on auth status
    if (isAuthenticated) {
      context.go('/Homescreen');
    } else {
      context.go('/signin');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _startTyping.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              // 1. Animated Background
              FadeTransition(
                opacity: _bgFadeAnimation,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0xFF2B4A35), // backgroundDark
                        Color(0xFF3A4F3A), // Middle
                        Color(0xFF5B5B3E), // backgroundLight
                      ],
                    ),
                  ),
                ),
              ),

              // 2. The Logo
              Center(
                child: Transform.scale(
                  scale: _logoScaleAnimation.value,
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // A. The Orange Fruit (Base layer)
                        FadeTransition(
                          opacity: _orangeFadeAnimation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: AppColors.fruitOrange,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Transform.translate(
                                  offset: const Offset(10, -10),
                                  child: Transform.scale(
                                    scale: _darkCircleScaleAnimation.value,
                                    child: Container(
                                      width: 73,
                                      height: 73,
                                      decoration: BoxDecoration(
                                        color: AppColors.accentDarkGreen,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(0, -18),
                                child: Container(
                                  width: 4,
                                  height: 38,
                                  color: AppColors.clockDetails,
                                ),
                              ),
                              Transform.rotate(
                                angle: _minuteHandAnimation.value,
                                alignment: Alignment.center,
                                child: Transform.translate(
                                  offset: const Offset(0, -18),
                                  child: Container(
                                    width: 4,
                                    height: 38,
                                    color: AppColors.clockDetails,
                                  ),
                                ),
                              ),
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.clockDetails,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // C. The Leaf
                        Transform.translate(
                          offset: Offset(0, -105 + (20 * _leafSlideAnimation.value)),
                          child: Transform.rotate(
                            angle: 0.545,
                            child: CustomPaint(
                              size: const Size(26, 52),
                              painter: AccurateLeafPainter(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 3. Typewriter Text
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.25,
                left: 0,
                right: 0,
                child: ValueListenableBuilder<bool>(
                  valueListenable: _startTyping,
                  builder: (context, start, child) {
                    if (!start) return const SizedBox.shrink();
                    return Column(
                      children: [
                        TypewriterText(
                          text: "Bitwise",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                          delay: const Duration(milliseconds: 50),
                        ),
                        const SizedBox(height: 8),
                        TypewriterText(
                          text: "Track. Eat. Thrive",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.5,
                          ),
                          delay: const Duration(milliseconds: 40),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// --- Custom Painter for the Accurate Leaf ---
class AccurateLeafPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final paint = Paint()
      ..color = AppColors.leafGreen
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(center.dx, center.dy);
    path.cubicTo(
        center.dx + 15, center.dy - 10,
        center.dx + 8,  center.dy - 35,
        center.dx,       center.dy - 52
    );
    path.cubicTo(
        center.dx - 8,  center.dy - 35,
        center.dx - 15, center.dy - 10,
        center.dx,       center.dy
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// --- Typewriter Animation Widget ---
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration delay;

  const TypewriterText({
    super.key,
    required this.text,
    required this.style,
    this.delay = const Duration(milliseconds: 50),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = "";
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer = Timer.periodic(widget.delay, (timer) {
      if (_currentIndex < widget.text.length) {
        setState(() {
          _displayedText += widget.text[_currentIndex];
          _currentIndex++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      style: widget.style,
    );
  }
}