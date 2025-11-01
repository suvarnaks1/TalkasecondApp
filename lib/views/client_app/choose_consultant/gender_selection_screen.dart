import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'problem_type_screen.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? selectedGender;

  final genders = ["Male", "Female", "No preference"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueBackground,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: const Text(
          "Choose Consultant",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select your preferred consultant gender",
              style: TextStyle(
                color: AppColors.myDarkColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),

            // Gender Cards
            Expanded(
              child: ListView.builder(
                itemCount: genders.length,
                itemBuilder: (context, index) {
                  String gender = genders[index];
                  bool isSelected = selectedGender == gender;

                  return GestureDetector(
                    onTap: () {
                      setState(() => selectedGender = gender);
                    },
                    child: Card(
                      color: isSelected
                          ? AppColors.accentColor.withOpacity(0.8)
                          : AppColors.colorwhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.backgroundColor
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(
                          gender == "Male"
                              ? Icons.male
                              : gender == "Female"
                                  ? Icons.female
                                  : Icons.person_outline,
                          color: AppColors.backgroundColor,
                          size: 34,
                        ),
                        title: Text(
                          gender,
                          style: TextStyle(
                            color: AppColors.myDarkColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Continue Button
            ElevatedButton(
              onPressed: selectedGender == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProblemTypeScreen(
                            selectedGender: selectedGender!,
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Center(
                child: Text(
                  "Continue",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
