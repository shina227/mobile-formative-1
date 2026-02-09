import 'package:flutter/material.dart';
import "add_assignment.dart";
import "edit_assignment.dart";

class AssignmentsScreen extends StatefulWidget {
  const AssignmentsScreen({super.key});

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // The Header
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          color: const Color(0xFF1A233A),
          padding: const EdgeInsets.only(left: 20, top: 50),
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
              const SizedBox(height: 5),
              Text(
                "2 upcoming, 1 completed",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Scrollable Area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Upcoming",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A233A),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Assignment Cards
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
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A233A),
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

          // Bottom Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddAssignment()),
                  );
                },
                icon: const Icon(Icons.add, color: Color(0xFF1A233A)),
                label: const Text(
                  "Add New Assignment",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC107), // Golden Yellow
                  foregroundColor: const Color(0xFF1A233A),
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

  // --- Helper Widget to Build the Assignment Row ---
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
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox
          Checkbox(
            value: isCompleted,
            onChanged: (val) {},
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A233A),
                  ),
                ),
                Text(
                  course,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    // Priority Chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: priorityColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: priorityColor.withOpacity(0.5),
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
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Actions
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditAssignment(
                    initialTitle: "Introduction to Leadership Essay",
                    initialCourse: "ALU 101",
                    initialPriority: "High",
                  ),
                ),
              );
            },
            child: const Icon(Icons.edit_outlined, color: Colors.grey),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.delete_outline, color: Colors.grey),
        ],
      ),
    );
  }
}
