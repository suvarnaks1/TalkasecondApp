import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:demotalkasecond/views/language_screen.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top header with image
            SizedBox(height: 40),
                        
                          
                          const Text(
             "About Us",
             style: TextStyle(
               fontSize: 24,
               fontWeight: FontWeight.bold,
               color: Colors.white,
             ),
             textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
             Image.asset(
             'assets/aboutUs.png', // your image asset
             width: 300,
             height: 300,
             fit: BoxFit.contain,
                          ),
        
            // About text section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Welcome to Talk A Second - your trusted platform for professional online counselling, Dietician services, and fitness training. Based in Kochi, Kerala, we are dedicated to supporting your mental and physical well-being through expert guidance and personalized care.\n\nOur team of qualified psychologists and counsellors is here to offer a safe, confidential space for you to address your emotional and mental health concerns.\n\nWhether you're dealing with stress, anxiety, relationship challenges, or personal growth goals, we are here to listen and guide you every step of the way.",
                style: TextStyle(
                  color: AppColors.colorwhite,
                  fontSize: 16,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
        SizedBox(height: 10,),
            // Bottom button
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LanguageSelectionScreen()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.colorwhite,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "Start",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
