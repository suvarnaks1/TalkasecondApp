import 'package:demotalkasecond/views/consultant/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:demotalkasecond/views/demo/demonav.dart';

class ConsultantBottomNav extends StatefulWidget {
  const ConsultantBottomNav({super.key});

  @override
  State<ConsultantBottomNav> createState() => _ConsultantBottomNavState();
}

class _ConsultantBottomNavState extends State<ConsultantBottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
  ConsultantHomeTabs(),
    const AppointmentDemoScreen(),
    const Center(
        child: Text('Appointments Page (FAB)',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    const Center(child: Text('Messages Page', style: TextStyle(fontSize: 24))),
    const Center(child: Text('More Page', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int bottomBarIndex) {
    setState(() {
      if (bottomBarIndex >= 2) {
        _selectedIndex = bottomBarIndex + 1;
      } else {
        _selectedIndex = bottomBarIndex;
      }
    });
  }

  void _onFabTapped() {
    setState(() {
      _selectedIndex = 2; // FAB maps to page index 2
    });
  }

  @override
  Widget build(BuildContext context) {
    // Typical FAB diameter is 56. Use that + notch margin as the center gap.
    const double fabDiameter = 56.0;
    const double notchMargin = 8.0;
    final double fabGap = fabDiameter + notchMargin * 2; // safe center gap

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Manager'),
        backgroundColor: AppColors.brandGreen,
        foregroundColor: AppColors.colorwhite,
      ),
      extendBody: true,
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabTapped,
        shape: const CircleBorder(),
        backgroundColor: AppColors.backgroundColor,
        foregroundColor: AppColors.colorwhite,
        child: const Icon(Icons.calendar_month),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SafeArea(
        top: false,
        child: BottomAppBar(
          color: AppColors.backgroundColor,
          shape: const CircularNotchedRectangle(),
          notchMargin: notchMargin,
          elevation: 8.0,
          child: SizedBox(
            height: 64, // enough for icon + label
            child: Row(
              children: <Widget>[
                // LEFT GROUP (Home, Doctors)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(0, 'Home', Icons.home_outlined, Icons.home),
                      _buildNavItem(1, 'Appointments', Icons.note, Icons.note),
                    ],
                  ),
                ),

                // CENTER GAP (for FAB) - sized to FAB diameter to avoid overflow
                SizedBox(width: fabGap),

                // RIGHT GROUP (Messages, More)
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(2, 'Sections', Icons.video_collection, Icons.chat_bubble),
                      _buildNavItem(3, 'Profile', Icons.person, Icons.grid_view),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int bottomBarIndex, String label, IconData unselectedIcon, IconData selectedIcon) {
    final pageIndex = (bottomBarIndex >= 2) ? bottomBarIndex + 1 : bottomBarIndex;
    final isSelected = _selectedIndex == pageIndex;
    final isFabPage = _selectedIndex == 2;
    final finalIsSelected = isSelected && !isFabPage;

    // Use Flexible/FittedBox for the label so it won't overflow horizontally
    return Flexible(
      fit: FlexFit.loose,
      child: InkWell(
        onTap: () => _onItemTapped(bottomBarIndex),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                finalIsSelected ? selectedIcon : unselectedIcon,
                color: finalIsSelected ? AppColors.colorwhite : AppColors.midGray,
                size: 24.0,
              ),
              const SizedBox(height: 4),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: finalIsSelected ? AppColors.colorwhite : AppColors.midGray,
                      fontSize: 12,
                      fontWeight: finalIsSelected ? FontWeight.bold : FontWeight.normal,
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
