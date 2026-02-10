import 'package:flutter/material.dart';
import 'dart:math' as math;

class AttendanceTrackingScreen extends StatefulWidget {
  const AttendanceTrackingScreen({super.key});

  @override
  State<AttendanceTrackingScreen> createState() =>
      _AttendanceTrackingScreenState();
}

class _AttendanceTrackingScreenState extends State<AttendanceTrackingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Attendance data
  final Map<String, dynamic> _attendanceData = {
    'studentName': 'Alex',
    'attendancePercentage': 75.0,
    'assignmentCompletion': 60.0,
    'averageGrade': 63.0,
    'totalClasses': 100,
    'classesAttended': 75,
    'totalAssignments': 20,
    'assignmentsCompleted': 12,
    'isAtRisk': true,
  };

  // Attendance history (recent sessions)
  final List<Map<String, dynamic>> _attendanceHistory = [
    {
      'date': '2026-02-10',
      'subject': 'Mathematics',
      'status': 'Present',
      'time': '09:00 AM',
    },
    {
      'date': '2026-02-09',
      'subject': 'Mobile Development',
      'status': 'Absent',
      'time': '02:00 PM',
    },
    {
      'date': '2026-02-08',
      'subject': 'Foundations',
      'status': 'Present',
      'time': '01:00 PM',
    },
    {
      'date': '2026-02-07',
      'subject': 'Data Structures',
      'status': 'Present',
      'time': '10:00 AM',
    },
    {
      'date': '2026-02-06',
      'subject': 'Web Development',
      'status': 'Absent',
      'time': '03:00 PM',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color _getRiskColor() {
    final attendance = _attendanceData['attendancePercentage'];
    if (attendance >= 75) {
      return Colors.green;
    } else if (attendance >= 60) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String _getRiskStatus() {
    final attendance = _attendanceData['attendancePercentage'];
    if (attendance >= 75) {
      return 'Good Standing';
    } else if (attendance >= 60) {
      return 'At Risk';
    } else {
      return 'Critical';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1F44),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1F44),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Your Risk Status',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Greeting
            _buildHeaderSection(),

            // Risk Status Cards
            _buildRiskStatusCards(),

            // Get Help Button
            _buildGetHelpButton(),

            const SizedBox(height: 20),

            // Attendance History Section
            _buildAttendanceHistory(),

            const SizedBox(height: 20),

            // Detailed Statistics
            _buildDetailedStats(),

            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello ${_attendanceData['studentName']} ${_getRiskStatus()}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _attendanceData['isAtRisk']
                ? 'Your attendance needs attention'
                : 'Keep up the good work!',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskStatusCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCircularIndicator(
            percentage: _attendanceData['attendancePercentage'],
            label: 'Attendance\nStamens',
            color: const Color(0xFFD32F2F),
          ),
          _buildCircularIndicator(
            percentage: _attendanceData['assignmentCompletion'],
            label: 'Assignment to\nEvalue',
            color: const Color(0xFFFFA000),
          ),
          _buildCircularIndicator(
            percentage: _attendanceData['averageGrade'],
            label: 'Average',
            color: const Color(0xFFD32F2F),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularIndicator({
    required double percentage,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return CustomPaint(
              size: const Size(90, 90),
              painter: CircularProgressPainter(
                progress: percentage / 100 * _animation.value,
                color: color,
                backgroundColor: Colors.white.withOpacity(0.2),
              ),
              child: SizedBox(
                width: 90,
                height: 90,
                child: Center(
                  child: Text(
                    '${(percentage * _animation.value).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  Widget _buildGetHelpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _showHelpDialog,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFFC107),
            foregroundColor: Colors.black,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: const Text(
            'Get Help',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceHistory() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Attendance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _attendanceHistory.length,
            separatorBuilder: (context, index) => Divider(
              color: Colors.white.withOpacity(0.1),
              height: 20,
            ),
            itemBuilder: (context, index) {
              final record = _attendanceHistory[index];
              return _buildAttendanceRecord(record);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceRecord(Map<String, dynamic> record) {
    final isPresent = record['status'] == 'Present';
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isPresent
                ? Colors.green.withOpacity(0.2)
                : Colors.red.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isPresent ? Icons.check_circle : Icons.cancel,
            color: isPresent ? Colors.green : Colors.red,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                record['subject'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${record['date']} • ${record['time']}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isPresent
                ? Colors.green.withOpacity(0.2)
                : Colors.red.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            record['status'],
            style: TextStyle(
              color: isPresent ? Colors.green : Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedStats() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detailed Statistics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          _buildStatRow(
            'Total Classes',
            _attendanceData['totalClasses'].toString(),
            Icons.school,
          ),
          const SizedBox(height: 12),
          _buildStatRow(
            'Classes Attended',
            _attendanceData['classesAttended'].toString(),
            Icons.check_circle,
          ),
          const SizedBox(height: 12),
          _buildStatRow(
            'Total Assignments',
            _attendanceData['totalAssignments'].toString(),
            Icons.assignment,
          ),
          const SizedBox(height: 12),
          _buildStatRow(
            'Completed Assignments',
            _attendanceData['assignmentsCompleted'].toString(),
            Icons.assignment_turned_in,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _attendanceData['attendancePercentage'] < 75
                  ? Colors.red.withOpacity(0.2)
                  : Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  _attendanceData['attendancePercentage'] < 75
                      ? Icons.warning
                      : Icons.info,
                  color: _attendanceData['attendancePercentage'] < 75
                      ? Colors.red
                      : Colors.green,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _attendanceData['attendancePercentage'] < 75
                        ? 'Alert: Your attendance is below 75%. Please improve to avoid academic penalties.'
                        : 'Great job! Your attendance is above the required threshold.',
                    style: TextStyle(
                      color: _attendanceData['attendancePercentage'] < 75
                          ? Colors.red
                          : Colors.green,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF051127),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.dashboard, 'Dashboard', false),
              _buildNavItem(Icons.calendar_today, 'Calender', false),
              _buildNavItem(Icons.insert_chart, 'Elearning', false),
              _buildNavItem(Icons.person, 'Profile', true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return InkWell(
      onTap: () {
        // Handle navigation
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF0A2463),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Get Help',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'We can help you improve your attendance. Choose an option:',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            _buildHelpOption(
              Icons.person,
              'Schedule Academic Advisor Meeting',
              () {
                Navigator.pop(context);
                _showSuccessMessage('Academic advisor meeting scheduled');
              },
            ),
            const SizedBox(height: 12),
            _buildHelpOption(
              Icons.email,
              'Email My Professor',
              () {
                Navigator.pop(context);
                _showSuccessMessage('Email template prepared');
              },
            ),
            const SizedBox(height: 12),
            _buildHelpOption(
              Icons.book,
              'View Study Resources',
              () {
                Navigator.pop(context);
                _showSuccessMessage('Redirecting to study resources');
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpOption(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// Custom painter for circular progress indicator
class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  CircularProgressPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final strokeWidth = 8.0;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - strokeWidth / 2, backgroundPaint);

    // Draw progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}