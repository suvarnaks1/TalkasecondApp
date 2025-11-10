import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile & Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/avatar.png')),
          SizedBox(height: 12),
          Text('Dr. Jane Smith', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text('Clinical Psychologist, 10 years experience'),
          const SizedBox(height: 24),
          ListTile(
            title: Text('Availability'),
            trailing: Icon(Icons.calendar_today),
            onTap: () { /* show slot calendar */ },
          ),
          ListTile(
            title: Text('Session Rate'),
            trailing: Text('₹1500'),
            onTap: () { /* edit rate */ },
          ),
          ListTile(
            title: Text('Ratings & Reviews'),
            trailing: Icon(Icons.chevron_right),
            onTap: () { /* navigate to reviews list */ },
          ),
        ],
      ),
    );
  }
}
