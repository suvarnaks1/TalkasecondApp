import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';

class PsychologistDashboard extends StatelessWidget {
  const PsychologistDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorwhite,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text('Welcome Dr. Smith', style: TextStyle(color: AppColors.colorwhite)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: AppColors.colorwhite),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _SummaryCardsRow(),
            const SizedBox(height: 24),
            Expanded(child: _UpcomingAppointmentsList()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
         type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: AppColors.accentColor,
        backgroundColor: AppColors.backgroundColor,
        unselectedItemColor: AppColors.midGray,
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

class _SummaryCardsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SummaryCard(title: 'Upcoming', value: '4'),
        const SizedBox(width: 12),
        _SummaryCard(title: 'Completed', value: '20'),
        const SizedBox(width: 12),
        _SummaryCard(title: 'Earnings', value: '₹12 000'),
      
       
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  const _SummaryCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE8F8F0), // light green background, adjust as needed
          border: Border.all(
            color: const Color(0xFF2ECC71), // green border color
            width: 1.0,                       // thin line
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                color: AppColors.midGray,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: AppColors.myDarkColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _UpcomingAppointmentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // For demo, using fixed number
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return _AppointmentCard();
      },
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom:16),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Client: J. D.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Sep 10, 2025 · 3:00 PM', style: TextStyle(color: AppColors.midGray)),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.videocam, size:16, color: AppColors.accentColor),
                const SizedBox(width:4),
                Text('Video session', style: TextStyle(color: AppColors.midGray)),
              ],
            ),
            const SizedBox(height: 12),
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      ElevatedButton(onPressed: () {}, child: const Text('View Profile')),
      const SizedBox(width:8),
      OutlinedButton(onPressed: () {}, child: const Text('Activate')),
      const SizedBox(width:8),
      OutlinedButton(onPressed: () {}, child: const Text('Reschedule')),
      const SizedBox(width:8),
      OutlinedButton(onPressed: () {}, child: const Text('Mark Completed')),
    ],
  ),
),

          ],
        ),
      ),
    );
  }
}
