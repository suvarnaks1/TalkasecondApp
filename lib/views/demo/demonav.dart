import 'package:flutter/material.dart';

// --- Data Models (Required for Card UI) ---

enum SessionMode { video, voice, chat }
enum AppointmentStatus { confirmed, rescheduled, pending }

class Appointment {
  final String clientId;
  final String clientName;
  final String dateTime;
  final SessionMode mode;
  final AppointmentStatus status;
  final bool hasReports;

  Appointment({
    required this.clientId,
    required this.clientName,
    required this.dateTime,
    required this.mode,
    required this.status,
    required this.hasReports,
  });
}

// --- Card Widget Implementation (Unmodified) ---

class UpcomingAppointmentsCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onViewProfile;
  final VoidCallback onActivateSession;
  final VoidCallback onReschedule;
  final VoidCallback onMarkCompleted;

  const UpcomingAppointmentsCard({
    super.key,
    required this.appointment,
    required this.onViewProfile,
    required this.onActivateSession,
    required this.onReschedule,
    required this.onMarkCompleted,
  });

  Color _getStatusColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.confirmed:
        return Colors.green.shade700;
      case AppointmentStatus.rescheduled:
        return Colors.orange.shade700;
      case AppointmentStatus.pending:
        return Colors.blue.shade700;
    }
  }

  IconData _getModeIcon(SessionMode mode) {
    switch (mode) {
      case SessionMode.video:
        return Icons.videocam;
      case SessionMode.voice:
        return Icons.phone;
      case SessionMode.chat:
        return Icons.chat_bubble;
    }
  }

  Widget _buildDetailRow(IconData icon, String title, String value, {Color color = Colors.black87}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 8),
        Text(
          '$title:',
          style: TextStyle(fontWeight: FontWeight.w600, color: color),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: color),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback? onPressed,
    Color backgroundColor = Colors.white,
    Color foregroundColor = Colors.black87,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        side: BorderSide(color: onPressed != null ? Colors.grey.shade400 : Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      ),
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isConfirmedOrRescheduled = 
        appointment.status == AppointmentStatus.confirmed || 
        appointment.status == AppointmentStatus.rescheduled;

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Top Row: Client Name & Status ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Client: ${appointment.clientName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text(
                    appointment.status.toString().split('.').last,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: _getStatusColor(appointment.status),
                ),
              ],
            ),
            const Divider(height: 16),

            // --- 2. Details: Date, Time, Mode, Reports ---
            _buildDetailRow(Icons.access_time, 'Date & Time', appointment.dateTime),
            const SizedBox(height: 8),
            _buildDetailRow(
              _getModeIcon(appointment.mode), 
              'Mode', 
              appointment.mode.toString().split('.').last.toUpperCase()
            ),
            const SizedBox(height: 8),

            // --- Reports Indicator ---
            if (appointment.hasReports)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _buildDetailRow(
                  Icons.description, 
                  'Reports', 
                  'Client uploaded files',
                  color: Colors.purple.shade700,
                ),
              ),

            // --- 3. Actions Row ---
            const Divider(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(
                    label: 'View Profile', icon: Icons.person_outline, onPressed: onViewProfile,
                  ),
                  const SizedBox(width: 8),
                  
                  _buildActionButton(
                    label: 'Activate Session',
                    icon: Icons.play_arrow,
                    onPressed: isConfirmedOrRescheduled ? onActivateSession : null,
                    backgroundColor: isConfirmedOrRescheduled ? Colors.red.shade700 : Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                  const SizedBox(width: 8),

                  _buildActionButton(
                    label: 'Reschedule', icon: Icons.event_repeat, onPressed: onReschedule,
                  ),
                  const SizedBox(width: 8),

                  _buildActionButton(
                    label: 'Mark Completed', icon: Icons.check_circle_outline, onPressed: onMarkCompleted,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- NEW PAGE FOR DOCTORS TAB (The Appointment List) ---
// This is the page that will load when you click the second bottom nav icon.

class AppointmentDemoScreen extends StatelessWidget {
  const AppointmentDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample Data
    final upcomingAppointments = [
      Appointment(
        clientId: 'C1001', clientName: 'Sarah J.', dateTime: 'Today, 2:00 PM',
        mode: SessionMode.video, status: AppointmentStatus.confirmed, hasReports: true,
      ),
      Appointment(
        clientId: 'C1002', clientName: 'Mark P.', dateTime: 'Tomorrow, 10:30 AM',
        mode: SessionMode.chat, status: AppointmentStatus.pending, hasReports: false,
      ),
      Appointment(
        clientId: 'C1003', clientName: 'Alex R.', dateTime: 'Wed, 4:00 PM',
        mode: SessionMode.voice, status: AppointmentStatus.rescheduled, hasReports: true,
      ),
    ];

    // Dummy action handlers
    void showAction(String action, String client) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$action for $client')),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Upcoming Appointments',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: upcomingAppointments.length,
              itemBuilder: (context, index) {
                final appt = upcomingAppointments[index];
                return UpcomingAppointmentsCard(
                  appointment: appt,
                  onViewProfile: () => showAction('View Profile', appt.clientName),
                  onActivateSession: () => showAction('Activate Session', appt.clientName),
                  onReschedule: () => showAction('Reschedule Request', appt.clientName),
                  onMarkCompleted: () => showAction('Mark Completed', appt.clientName),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

