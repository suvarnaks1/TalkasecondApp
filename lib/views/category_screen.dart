
import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int selectedIndex = -1;
  String? selectedRole;

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Client App (Users / Patients)',
      'description':
          'For clients seeking counselling, dietician, physician, or fitness consultations. Easy booking, payment, and communication system.',
      'icon': Icons.people_alt_rounded,
    },
    {
      'title': 'Consultant + Admin + Support App',
      'description':
          'Single app with role-based logins: Psychologists, Psychiatrists, Dieticians, Physicians, Trainers, Department Heads, Technical/Support Team, Director (full access). Accessible via mobile & web for convenience.',
      'icon': Icons.admin_panel_settings_rounded,
    },
  ];

  final List<String> consultantRoles = [
    'Psychologist',
    'Psychiatrist',
    'Dietician',
    'Physician',
    'Trainer',
    'Department Head',
    'Technical/Support Team',
    'Director',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlueBackground,
      appBar: AppBar(
        title: const Text('Choose Category'),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final item = categories[index];
                  final isSelected = selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        selectedRole = null; // reset dropdown when changing category
                      });
                    },
                    child: Card(
                      color: isSelected
                          ? AppColors.accentColor.withOpacity(0.8)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.backgroundColor
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              item['icon'],
                              color: AppColors.backgroundColor,
                              size: 40,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['title'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.myDarkColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    item['description'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.midGray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // 👇 Show dropdown if "Consultant + Admin + Support App" selected
            if (selectedIndex == 1) ...[
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Role:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.myDarkColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: selectedRole,
                hint: const Text('Choose your role'),
                items: consultantRoles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedRole = value;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),

      // ✅ Bottom Submit Button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: (selectedIndex == -1 ||
                    (selectedIndex == 1 && selectedRole == null))
                ? null
                : () {
                    String selectedCategory =
                        categories[selectedIndex]['title'];
                    String? role = selectedRole;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          selectedIndex == 1
                              ? 'Selected: $selectedCategory → $role'
                              : 'Selected: $selectedCategory',
                        ),
                      ),
                    );
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.backgroundColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
