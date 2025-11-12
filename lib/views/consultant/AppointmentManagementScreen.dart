import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppointmentManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appointments')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, idx) {
          return AppointmentCard(
            clientName: 'John D.',
            dateTime: 'Sep 10, 2025 - 3:00 PM',
            mode: 'Video',
            status: 'Confirmed',
          );
        },
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String clientName;
  final String dateTime;
  final String mode;
  final String status;

  const AppointmentCard({
    required this.clientName,
    required this.dateTime,
    required this.mode,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(clientName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(dateTime, style: TextStyle(color: AppColors.midGray)),
            Text('Mode: $mode', style: TextStyle(color: AppColors.midGray)),
            SizedBox(height: 8),
            Text('Status: $status', style: TextStyle(color: AppColors.accentColor)),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton(onPressed: () => _viewProfile(context), child: Text('View Profile')),
                SizedBox(width: 8),
                ElevatedButton(onPressed: () => _activateSession(context), child: Text('Activate')),
                SizedBox(width: 8),
                OutlinedButton(onPressed: () => _reschedule(context), child: Text('Reschedule')),
                SizedBox(width: 8),
                OutlinedButton(onPressed: () => _markCompleted(context), child: Text('Mark Completed')),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _viewProfile(BuildContext context) {
    // Navigate to profile screen
  }
  void _activateSession(BuildContext context) { /* ... */ }
  void _reschedule(BuildContext context) { /* ... */ }
  void _markCompleted(BuildContext context) { /* ... */ }
}
