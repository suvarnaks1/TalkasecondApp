import 'package:demotalkasecond/views/client_app/choose_consultant/problem_type_screen.dart';
import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});
  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? selectedGender;

  final List<String> genders = ["Male", "Female", "No preference"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorwhite,
      // Use no AppBar to match full screen style in the image
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder for a square image/avatar at top
              Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor, // placeholder background
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.person, size: 60, color: Colors.white),
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  "Introduce Yourself",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Fill out the rest of your details so people know a little more about you",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Gender selection cards
              for (var gender in genders) ...[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGender = gender;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: selectedGender == gender
                          ? AppColors.accentColor
                          : AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selectedGender == gender
                            ? AppColors.accentColor
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          gender == "Male"
                              ? Icons.male
                              : gender == "Female"
                              ? Icons.female
                              : Icons.person_outline,
                          size: 28,
                          color: selectedGender == gender
                              ? Colors.white
                              : Colors.grey,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          gender,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: selectedGender == gender
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              const Spacer(),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (selectedGender != null)
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProblemTypeScreen(
                                selectedGender: selectedGender!,
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
