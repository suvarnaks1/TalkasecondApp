import 'package:demotalkasecond/views/Auth/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:demotalkasecond/common/colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorwhite,
      body: Column(
        children: [
          // Wavy top header
          Expanded(
            flex: 3,
            child: ClipPath(
              clipper: _WaveClipper(),
              child: Container(
                width: double.infinity,
                color: AppColors.backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                 
                    const SizedBox(height: 20),
                    const Text(
                      "About Talk A Second",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // About text section
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Text(
                  "Welcome to Talk A Second - your trusted platform for professional online counselling, Dietician services, and fitness training. Based in Kochi, Kerala, we are dedicated to supporting your mental and physical well-being through expert guidance and personalized care.\n\nOur team of qualified psychologists and counsellors is here to offer a safe, confidential space for you to address your emotional and mental health concerns.\n\nWhether you're dealing with stress, anxiety, relationship challenges, or personal growth goals, we are here to listen and guide you every step of the way.",
                  style: TextStyle(
                    color: AppColors.myDarkColor,
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),

          // Bottom button
          Container(
            width: double.infinity,
            color: AppColors.colorwhite,
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: GestureDetector(
                onTap: () {
                 Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Start",
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
        ],
      ),
    );
  }
}

// Reusing same wave clipper from welcome screen
class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.75);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height * 0.75);
    path.quadraticBezierTo(
        firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 3 / 4, size.height * 0.5);
    var secondEndPoint = Offset(size.width, size.height * 0.75);
    path.quadraticBezierTo(
        secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
