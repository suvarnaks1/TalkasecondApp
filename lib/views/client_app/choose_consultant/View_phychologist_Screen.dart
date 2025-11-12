import 'package:demotalkasecond/views/client_app/choose_consultant/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';

class View_phychologist_Screen extends StatelessWidget {
  final Map<String, dynamic> doctorData;

  const View_phychologist_Screen({super.key, required this.doctorData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorwhite,
      appBar: AppBar(  iconTheme: const IconThemeData(
    color: Colors.white,  // <-- back icon becomes white
  ),
        backgroundColor: AppColors.backgroundColor,
        title: Text(doctorData["name"], style: const TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(doctorData["photo"]),
              ),
              const SizedBox(height: 16),
              Text(
                doctorData["name"],
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                doctorData["speciality"],
                style: TextStyle(color: AppColors.midGray, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text("Experience: ${doctorData["experience"]}"),
              Text("Rating: ⭐ ${doctorData["rating"]}"),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),
              const Text(
                "About Doctor",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Dr. ${"This expert psychologist specializes in mental wellness, "
                    "stress management, and personalized counselling sessions to "
                    "help you achieve a balanced and healthy lifestyle."}",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                ),
                onPressed: () {

                   Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                           BookingScreen(doctorData: doctorData)
                                      ),
                                    );
                },
                child: const Text("Book Appointment", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
