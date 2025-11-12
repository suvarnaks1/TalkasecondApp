import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:demotalkasecond/views/consultant/Home/home_screen.dart';

class PsychologistDashboard extends StatefulWidget {
  const PsychologistDashboard({Key? key}) : super(key: key);

  @override
  State<PsychologistDashboard> createState() => _PsychologistDashboardState();
}

class _PsychologistDashboardState extends State<PsychologistDashboard> {
  int _selectedIndex = 0;

  // Screens for each tab
  final List<Widget> _screens = [
    ConsultantHomeTabs(),
    Center(child: Text("Appointments", style: TextStyle(fontSize: 18))),
    Center(child: Text("Sessions", style: TextStyle(fontSize: 18))),
    Center(child: Text("Profile", style: TextStyle(fontSize: 18))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.accentColor,
        unselectedItemColor: AppColors.colorwhite,
        backgroundColor: AppColors.backgroundColor,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.video_call), label: 'Sessions'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
