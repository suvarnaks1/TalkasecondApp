import 'package:demotalkasecond/views/demo/demo_gender.dart';
import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:demotalkasecond/views/client_app/choose_consultant/gender_selection_screen.dart';
import 'package:demotalkasecond/views/client_app/choose_dietician.dart/Purpose_Selection.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // list data defined inline
    final List<Map<String, dynamic>> services = [
      {
        'title': "Counselling session",
        'image': "assets/counselling.png",
        'buttonText': "Book an Appointment",
        'color': const Color(0xFF2E7D5E),
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DemoGender()),
          );
        },
      },
      {
        'title': "Dietitian / Fitness Trainer",
        'image': "assets/dietplan.png",
        'buttonText': "Book an Appointment",
        'color': const Color(0xFF197D83),
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PurposeSelectionScreen()),
          );
        },
      },
      {
        'title': "Webinar Session",
        'image': "assets/webinar.png",
        'buttonText': "Book Your Seats",
        'color': const Color(0xFFB76E26),
        'onTap': () {
          // Webinar action
        },
      },
      // Add more entries here if needed
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF2E554F), // dark green background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Talk, Share and Smile Always.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "What type of support are you looking for?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              // Scrollable list of cards
              Expanded(
                child: ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final item = services[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: _buildServiceCard(
                        context,
                        title: item['title'] as String,
                        image: item['image'] as String,
                        buttonText: item['buttonText'] as String,
                        color: item['color'] as Color,
                        onTap: item['onTap'] as VoidCallback,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required String image,
    required String buttonText,
    required Color color,
    required VoidCallback onTap,
    Color textColor = Colors.white,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 12),
            Image.asset(image, height: 140, fit: BoxFit.contain),
            const SizedBox(height: 12),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: textColor),
                foregroundColor: textColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: onTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(buttonText),
                  const SizedBox(width: 5),
                  Icon(Icons.arrow_forward, size: 18, color: textColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
