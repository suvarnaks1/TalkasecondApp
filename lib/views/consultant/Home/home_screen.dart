import 'package:demotalkasecond/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ConsultantHomeTabs extends StatelessWidget {
  const ConsultantHomeTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // The length must match the number of tabs (3)
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          
          // 1. Add toolbarHeight to increase the main part of the AppBar
          toolbarHeight: 100, // Increased from the default 56.0
          title: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30, // reduce radius to fit well in AppBar
                    backgroundImage: AssetImage(
                      'assets/pro.png',
                    ), // use AssetImage
                  ),
                  const SizedBox(width: 8), // Add spacing
                  const Text(
                    "hi Dr Suvarna",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(), // Use Spacer to push the icon button to the right
                  IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
                ],
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: AppColors.colorwhite,
          // 2. Adjust the PreferredSize in 'bottom' to increase the tab bar area height
          bottom: PreferredSize(
            // Increased the height to, say, 80 (was 60)
            preferredSize: const Size.fromHeight(80),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.colorwhite,
                borderRadius: BorderRadius.circular(40),
              ),
              child: TabBar(
                splashBorderRadius: BorderRadius.circular(40),
                indicator: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: AppColors.backgroundColor,
                labelPadding: const EdgeInsets.symmetric(horizontal: 24),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: '   Upcoming   '),
                  Tab(text: '   Completed   '),
                  Tab(text: '   Wallets   '),
                ],
              ),
            ),
          ),
        ),

        // --- START: Integration of the TabBarView Content ---
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  // 1. Upcoming: Use GridView.builder for Appointments
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
                                  backgroundImage: const AssetImage('assets/pro.png'),
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
                                  // NOTE: Using NetworkImage which may require internet access
                                  backgroundImage: const NetworkImage(
                                    'https://example.com/avatar_completed_0.jpg',
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
        // --- END: Integration of the TabBarView Content ---
      ),
    );
  }
}