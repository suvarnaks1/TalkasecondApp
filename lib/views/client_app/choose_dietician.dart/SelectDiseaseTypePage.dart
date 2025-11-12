import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:demotalkasecond/views/client_app/choose_dietician.dart/UploadMedicalReportPage.dart';
import 'package:flutter/material.dart';

class SelectDiseaseTypeScreen extends StatefulWidget {
  const SelectDiseaseTypeScreen({super.key});

  @override
  State<SelectDiseaseTypeScreen> createState() => _SelectDiseaseTypePageState();
}

class _SelectDiseaseTypePageState extends State<SelectDiseaseTypeScreen> {
  String? selectedDisease;

  final List<String> diseaseList = [
    "Cholesterol",
    "Sugar (Diabetes)",
    "Blood Pressure",
    "Thyroid",
    "Other lifestyle-related diseases",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorwhite,

      // ✅ AppBar added here
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 4,
        centerTitle: true,
        title: const Text(
                "Select Disease Type",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
       
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              const SizedBox(height: 30),

              // Disease options
              ...diseaseList.map((disease) {
                final isSelected = disease == selectedDisease;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedDisease = disease;
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.accentColor
                            : AppColors.lightPeach,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.midGray.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(2, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 16),
                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: AppColors.myDarkColor,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            disease,
                            style: TextStyle(
                              color: AppColors.myDarkColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),

              const Spacer(),

              // Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedDisease != null
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UploadMedicalReportScreen(),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      color: AppColors.colorwhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
