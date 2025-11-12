import 'package:flutter/material.dart';

class SessionScreen extends StatelessWidget {
  final String clientName;
  final String mode; // Video/Voice/Chat

  const SessionScreen({required this.clientName, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Session with $clientName')),
      body: Center(
        child: Column(
          children: [
            Expanded(child: Placeholder()), // Video/voice session UI
            ElevatedButton(
              onPressed: () => _uploadNotes(context),
              child: Text('Upload Notes / Report'),
            )
          ],
        ),
      ),
    );
  }

  void _uploadNotes(BuildContext context) {
    // navigate to upload form
  }
}
