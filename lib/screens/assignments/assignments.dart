import 'package:flutter/material.dart';
import "add_assignment.dart";
import "edit_assignment.dart";

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  // primary dark navy color
  final Color navyBackground = const Color(0xFF1A233A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navyBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Container(
          color: navyBackground,
          padding: const EdgeInsets.only(left: 20, top: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "My Assignments",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                "2 upcoming, 1 completed",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // separator between header and list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: Colors.white.withValues(alpha: 0.15),
              thickness: 1,
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Upcoming",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),

                  _buildAssignmentCard(
                    title: "Group Assignment",
                    course: "Mobile Application Development",
                    priority: "High",
                    priorityColor: Colors.red,
                    dueDate: "Feb 15",
                    isCompleted: false,
                  ),
                  _buildAssignmentCard(
                    title: "Media Queries Assignment",
                    course: "Frontend Development",
                    priority: "Medium",
                    priorityColor: Colors.orange,
                    dueDate: "Feb 20",
                    isCompleted: false,
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Completed",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),

                  _buildAssignmentCard(
                    title: "Edpuzzle",
                    course: "HIST 150",
                    priority: "Low",
                    priorityColor: Colors.green,
                    dueDate: "Feb 25",
                    isCompleted: true,
                  ),
                ],
              ),
            ),
          ),

          // Add New Assignment Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAssignment(),
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Color(0xFF1A233A)),
                label: const Text(
                  "Add New Assignment",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC107),
                  foregroundColor: const Color(0xFF1A233A),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentCard({
    required String title,
    required String course,
    required String priority,
    required Color priorityColor,
    required String dueDate,
    required bool isCompleted,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: isCompleted,
            activeColor: navyBackground,
            onChanged: (val) {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: navyBackground,
                  ),
                ),
                Text(
                  course,
                  style: TextStyle(
                    color: navyBackground.withValues(alpha: 0.6),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: priorityColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: priorityColor.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.circle, size: 8, color: priorityColor),
                          const SizedBox(width: 5),
                          Text(
                            priority,
                            style: TextStyle(
                              color: priorityColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      "Due $dueDate",
                      style: TextStyle(
                        color: navyBackground.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Edit and Delete icons
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditAssignment(
                    initialTitle: title,
                    initialCourse: course,
                    initialPriority: priority,
                  ),
                ),
              );
            },
            child: Icon(
              Icons.edit_outlined,
              color: navyBackground.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            Icons.delete_outline,
            color: navyBackground.withValues(alpha: 0.4),
          ),
        ],
      ),
    );
  }
}
