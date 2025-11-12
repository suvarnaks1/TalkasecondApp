import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'View_phychologist_Screen.dart';

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
      backgroundColor: AppColors.colorwhite,
      appBar: AppBar(elevation: 4,
        iconTheme: const IconThemeData(
    color: Colors.white,  // <-- back icon becomes white
  ),
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          "Available Psychologists",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Showing $gender specialists for $problemType",
              style: TextStyle(color: AppColors.myDarkColor, fontSize: 16),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = constraints.maxWidth >= 900
                      ? 4
                      : constraints.maxWidth >= 600
                      ? 3
                      : 2;

                  return GridView.builder(
                    itemCount: psychologists.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.68,
                    ),
                    itemBuilder: (context, index) {
                      final doc = psychologists[index];
                      return Card(
                        color: AppColors.backgroundColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(doc["photo"]),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                doc["name"],
                                style: TextStyle(
                                  color: AppColors.myDarkColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                doc["speciality"],
                                style: TextStyle(color: AppColors.lightBlueBackground),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${doc["rating"]} • ${doc["experience"]}",
                                    style: TextStyle(
                                      color: AppColors.lightBlueBackground,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                     Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>View_phychologist_Screen(doctorData: doc)
                                           
                                      ),
                                    );
                                  },
                                  child: Text(
                                  
                                    "Click",style: TextStyle(color: AppColors.colorwhite)),
                                ),
                                ),
                              
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
