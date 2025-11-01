import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';

class PsychologistListScreen extends StatelessWidget {
  final String gender;
  final String problemType;

  const PsychologistListScreen({
    super.key,
    required this.gender,
    required this.problemType,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> psychologists = [
      {
        "name": "Dr. Neha Thomas",
        "rating": 4.8,
        "experience": "7 years",
        "speciality": "Anxiety, Stress",
        "photo": "https://i.pravatar.cc/150?img=47",
      },
      {
        "name": "Dr. Arun Menon",
        "rating": 4.6,
        "experience": "10 years",
        "speciality": "Couple Therapy, OCD",
        "photo": "https://i.pravatar.cc/150?img=12",
      },
      {
        "name": "Dr. Meera Pillai",
        "rating": 4.9,
        "experience": "8 years",
        "speciality": "Depression, Anger Issues",
        "photo": "https://i.pravatar.cc/150?img=32",
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.lightBlueBackground,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text("Available Psychologists", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: psychologists.length,
        itemBuilder: (context, index) {
          final doc = psychologists[index];
          return Card(
            color: AppColors.colorwhite,
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(doc["photo"]),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc["name"],
                          style: TextStyle(
                            color: AppColors.myDarkColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          doc["speciality"],
                          style: TextStyle(color: AppColors.midGray),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            Text("${doc["rating"]} • ${doc["experience"]}",
                                style: TextStyle(color: AppColors.midGray)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios,
                        color: AppColors.backgroundColor, size: 20),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
