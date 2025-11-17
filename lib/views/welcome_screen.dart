import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:demotalkasecond/views/about_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorwhite,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.backgroundColor,
              AppColors.backgroundColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  const SizedBox(height: 100),
// Hero Image with Cloud Background
Stack(
  alignment: Alignment.center,
  children: [
    // Cloud-like background container
    Container(
      width: 260,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(80),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 30,
            spreadRadius: 10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
    ),

    // Hero Image Animation
    TweenAnimationBuilder(
      tween:
          Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutBack,
      builder: (context, Offset offset, child) {
        return Transform.translate(
          offset: offset * 100,
          child: child,
        );
      },
      child: Hero(
        tag: "logo",
        child: Image.asset('assets/pro.png')
      ),
    ),
  ],
),


                  const SizedBox(height: 40),

                  // Title Text Animation
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeIn,
                    builder: (context, value, child) {
                      return Opacity(opacity: value, child: child);
                    },
                    child: Text(
                      "Welcome to Talk A Second",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorwhite,
                        letterSpacing: 0.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Subtitle Text Animation
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Opacity(opacity: value, child: child);
                    },
                    child: Text(
                      "Your trusted platform for online counselling, diet, and fitness support — all in one place.",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const Spacer(),

                  // Button Slide-in Animation
                  TweenAnimationBuilder(
                    tween: Tween<Offset>(
                        begin: const Offset(0, 1), end: Offset.zero),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutCubic,
                    builder: (context, Offset offset, child) {
                      return Transform.translate(
                        offset: offset * 60,
                        child: child,
                      );
                    },
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.colorwhite,
                        foregroundColor: AppColors.backgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 90, vertical: 16),
                        elevation: 8,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => AboutUs()),
                        );
                      },
                      child: const Text(
                        "Get Started →",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
