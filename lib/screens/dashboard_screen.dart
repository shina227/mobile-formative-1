import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'assignment_screen.dart';
import 'profile_screen.dart';
import 'schedule_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // This variable stores the currently selected tab index
  int _selectedIndex = 0;

  // List of all screens for BottomNavigationBar
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    // Initialize screens list
    _screens = [
      const DashboardContent(),
      const ScheduleScreen(),
      const AssignmentsScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background color from ALU branding
      backgroundColor: AppColors.primary,

      // Display selected screen dynamically
      body: _screens[_selectedIndex],

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,

        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },

        backgroundColor: AppColors.secondary,

        selectedItemColor: AppColors.highlight,

        unselectedItemColor: AppColors.grey,

        showUnselectedLabels: true,

        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Schedule",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Assignments",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// This widget represents the content of the Dashboard tab
class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text(
                    "Dashboard",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Icon(Icons.person_outline, color: AppColors.white, size: 28),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Text(
                    "Mathematics",
                    style: TextStyle(color: AppColors.white, fontSize: 16),
                  ),

                  const SizedBox(width: 4),

                  Icon(Icons.keyboard_arrow_down, color: AppColors.white),
                ],
              ),

              const SizedBox(height: 24),

              Text(
                "Tuesday, 21 January 2026",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "Academic Week 4",
                style: TextStyle(color: AppColors.white, fontSize: 14),
              ),

              const SizedBox(height: 16),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: AppColors.warning,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  children: [
                    Icon(Icons.warning, color: AppColors.white),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        "Attendance below 75%. Please improve your attendance.",
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              dashboardCard(
                title: "Attendance",
                children: const [
                  Text("Attendance rate: 68%"),
                  Text("Classes missed: 3"),
                ],
              ),

              const SizedBox(height: 20),

              dashboardCard(
                title: "Today's Classes",
                children: const [
                  Text("Linear Algebra - 10:00 AM"),
                  Text("Programming - 2:00 PM"),
                ],
              ),

              const SizedBox(height: 20),

              dashboardCard(
                title: "Upcoming Assignments",
                children: const [
                  Text("PCA Assignment - Due Jan 25"),
                  Text("Flutter Assignment - Due Jan 28"),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget dashboardCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppColors.white,

        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          ...children,
        ],
      ),
    );
  }
}
