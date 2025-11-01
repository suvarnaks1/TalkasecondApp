import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'psychologist_list_screen.dart';

class ProblemTypeScreen extends StatefulWidget {
  final String selectedGender;
  const ProblemTypeScreen({super.key, required this.selectedGender});

  @override
  State<ProblemTypeScreen> createState() => _ProblemTypeScreenState();
}

class _ProblemTypeScreenState extends State<ProblemTypeScreen> {
  String? selectedProblem;

  final problems = [
    "Couple Therapy",
    "Depression",
    "Anxiety",
    "Stress",
    "OCD",
    "Anger Issues",
    "Sleep Disorders"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueBackground,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text("Select Problem Type", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What kind of issue are you facing?",
              style: TextStyle(
                color: AppColors.myDarkColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),

            // Problem list
            Expanded(
              child: ListView.builder(
                itemCount: problems.length,
                itemBuilder: (context, index) {
                  String problem = problems[index];
                  bool isSelected = selectedProblem == problem;
                  return GestureDetector(
                    onTap: () => setState(() => selectedProblem = problem),
                    child: Card(
                      color: isSelected
                          ? AppColors.accentColor.withOpacity(0.8)
                          : AppColors.colorwhite,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(Icons.healing,
                            color: AppColors.backgroundColor, size: 30),
                        title: Text(
                          problem,
                          style: TextStyle(
                            color: AppColors.myDarkColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            ElevatedButton(
              onPressed: selectedProblem == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PsychologistListScreen(
                            gender: widget.selectedGender,
                            problemType: selectedProblem!,
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
              child: const Text(
                "Continue",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
