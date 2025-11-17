import 'package:flutter/material.dart';
import 'package:demotalkasecond/core/utils/app_colors.dart';

class ConsultantHomeTabs extends StatelessWidget {
  const ConsultantHomeTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: Row(
           
            children: [
              SizedBox(width: 80,),
              const Text('Dashboard', style: TextStyle(color: Colors.white)),
             SizedBox(width: 86),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications),
              ),
            ],
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
        ),

        body: Column(
          children: [
            Container(
              color: AppColors.colorwhite,
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
                  // 1. Upcoming: Use GridView.builder
                  GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 6, // number of upcoming appointments
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 columns
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 3 / 4, // width : height ratio
                    ),
                    itemBuilder: (ctx, idx) {
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            // handle tap
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Profile avatar
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage('assets/meee-removebg-preview.png'),
                                  backgroundColor: AppColors.lightBlueBackground,
                                ),

                                const SizedBox(height: 12),

                                // Name / Title
                                Text(
                                  'Client Rahul ${idx + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 8),

                                // Date & Time
                                Text(
                                  '12 Nov, 3:00 PM',
                                  style: TextStyle(color: AppColors.midGray),
                                  textAlign: TextAlign.center,
                                ),

                                const Spacer(),

                                // Action button or icon
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.arrow_forward_ios, color: AppColors.accentColor),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // 2. Completed Sessions: Also as GridView
                  GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 4, // number of completed sessions
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 3 / 4,
                    ),
                    itemBuilder: (ctx, idx) {
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () {
                            // open session detail
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage: NetworkImage(
                                    'https://example.com/avatar_completed_$idx.jpg',
                                  ),
                                  backgroundColor: AppColors.lightBlueBackground,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Session ${idx + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Completed on 10 Nov',
                                  style: TextStyle(color: AppColors.midGray),
                                  textAlign: TextAlign.center,
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Icon(Icons.star, color: Colors.amber),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // 3. Wallet / Earnings summary (same as before)
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
