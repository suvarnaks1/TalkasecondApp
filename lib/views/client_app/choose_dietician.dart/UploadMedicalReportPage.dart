import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:flutter/material.dart';


class UploadMedicalReportPage extends StatefulWidget {
  const UploadMedicalReportPage({super.key});

  @override
  State<UploadMedicalReportPage> createState() =>
      _UploadMedicalReportPageState();
}

class _UploadMedicalReportPageState extends State<UploadMedicalReportPage> {
  String? uploadedFileName;
  final TextEditingController remarksController = TextEditingController();

  // Future<void> _pickFile() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf', 'jpg', 'png', 'jpeg'],
  //   );

  //   if (result != null) {
  //     setState(() {
  //       uploadedFileName = result.files.single.name;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                "Upload Medical Report",
                style: TextStyle(
                  color: AppColors.myDarkColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Upload button
              InkWell(
                //onTap: _pickFile,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.lightPeach,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.midGray.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(2, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.upload_file,
                          color: AppColors.backgroundColor, size: 28),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          uploadedFileName ?? "Upload report (PDF / Image)",
                          style: TextStyle(
                            color: AppColors.myDarkColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Remarks text field
              Text(
                "Doctor’s notes / symptoms / history",
                style: TextStyle(
                  color: AppColors.myDarkColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: remarksController,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.colorwhite,
                  hintText: "Write here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Privacy note
              Row(
                children: [
                  Icon(Icons.lock, size: 20, color: AppColors.midGray),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Uploaded report can only be accessed by your selected dietician.",
                      style: TextStyle(
                        color: AppColors.midGray,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // After submit, move to psychologist-like flow
                    // Navigate to Choose Dietician screen (similar flow)
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    "Submit",
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
