import 'package:demotalkasecond/views/about_screen.dart';
import 'package:flutter/material.dart';
import 'package:demotalkasecond/common/colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorwhite,
      body: Column(
        children: [
          // Wavy top half
          Expanded(
            flex: 3,
            child: ClipPath(
              clipper: _WaveClipper(),              // custom clipper for wave shape
              child: Container(
                width: double.infinity,
                color: AppColors.backgroundColor,   // your green color
                child: Column(
                  
                  children: [
                    SizedBox(height: 150,),
                    Image.asset(
                      "assets/meee.png",             // replace with your logo asset
                      height: 120,
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      "Welcome to Talk A Second",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "your trusted platform for professional online counselling, Dietician services, and fitness training.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom area with green background and Skip button
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: AppColors.colorwhite,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => AboutScreen()),
      );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Skip →",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom clipper for wave shape
class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.75);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height * 0.75);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 3 / 4, size.height * 0.5);
    var secondEndPoint = Offset(size.width, size.height * 0.75);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
