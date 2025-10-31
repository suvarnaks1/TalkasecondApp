import 'dart:async';
import 'package:demotalkasecond/views/Auth/views/login_screen.dart';
import 'package:demotalkasecond/common/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Timer(const Duration(seconds: 2), () {
      // keep splash 2 seconds (change as you like)
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF325343),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.backgroundColor,
        child: Center(
          child: Text(
            "TalkaSecond",
            style: TextStyle(
              color: AppColors.colorwhite,
               fontSize: 20,fontWeight: FontWeight.bold,
               ),
          ),
        ),
      ),
    );
  }
}

