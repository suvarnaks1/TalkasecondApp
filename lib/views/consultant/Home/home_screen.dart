import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';

class ConsultantHomeTabs extends StatelessWidget {
  const ConsultantHomeTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // four tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: Row(
            children: [
              SizedBox(width: 80),
              const Text('Dashboard', style: TextStyle(color: Colors.white)),
              SizedBox(width: 80),
              IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
            ],
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Column(
          children: [
            Container(
              color: AppColors.lightBlueBackground,
              child: TabBar(
                indicatorColor: AppColors.accentColor,
                labelColor: AppColors.accentColor,
                unselectedLabelColor: AppColors.midGray,
                tabs: const [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Wallet'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // 1. Upcoming Appointments
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 5,
                    itemBuilder: (ctx, idx) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const Icon(Icons.calendar_today),
                          title: Text('Appointment #${idx + 1}'),
                          subtitle: const Text('Date · Time'),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                      );
                    },
                  ),

                  // 2. Completed Sessions
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 3,
                    itemBuilder: (ctx, idx) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const Icon(Icons.check_circle_outline),
                          title: Text('Session #${idx + 1}'),
                          subtitle: const Text('Completed on Date'),
                          trailing: const Icon(Icons.star),
                        ),
                      );
                    },
                  ),

                  // 3. Wallet / Earnings summary
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total Earnings',
                          style: TextStyle(
                            color: AppColors.midGray,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₹ 12,00,000',
                          style: TextStyle(
                            color: AppColors.myDarkColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accentColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 24,
                            ),
                          ),
                          onPressed: () {
                            // View wallet details
                          },
                          child: const Text(
                            'View Details',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 4. Notifications
                  ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const Icon(Icons.notifications),
                          title: const Text('New booking received'),
                          subtitle: const Text('Client XYZ · 10 mins ago'),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const Icon(Icons.notifications_active),
                          title: const Text('Reschedule request'),
                          subtitle: const Text('Client ABC · 2 hrs ago'),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const Icon(Icons.people),
                          title: const Text('Referral alert'),
                          subtitle: const Text('You got a new referral!'),
                        ),
                      ),
                    ],
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
