import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:demotalkasecond/views/client_app/choose_dietician.dart/SelectDiseaseTypePage.dart';
import 'package:flutter/material.dart';


class PurposeSelectionPage extends StatelessWidget {
  const PurposeSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60),
              Text(
                "Select Your Purpose",
                style: TextStyle(
                  color: AppColors.myDarkColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              
              // Option 1
              _PurposeOptionCard(
                title: "Lifestyle Disease Management",
                icon: Icons.favorite,
                onTap: () {
                  // Navigate to next page or perform action
                          Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => SelectDiseaseTypePage()),
      );
                },
              ),

              const SizedBox(height: 20),

              // Option 2
              _PurposeOptionCard(
                title: "Weight Management",
                icon: Icons.fitness_center,
                onTap: () {
                  // Navigate to next page or perform action
                                   Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => SelectDiseaseTypePage()),
      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PurposeOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _PurposeOptionCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightPeach,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.midGray.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.accentColor,
              radius: 25,
              child: Icon(icon, color: AppColors.myDarkColor, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: AppColors.myDarkColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: AppColors.midGray, size: 18),
          ],
        ),
      ),
    );
  }
}
