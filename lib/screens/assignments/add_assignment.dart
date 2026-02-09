import 'package:flutter/material.dart';

class AddAssignment extends StatefulWidget {
  const AddAssignment({super.key});

  @override
  State<AddAssignment> createState() => _AddAssignmentState();
}

class _AddAssignmentState extends State<AddAssignment> {
  final _titleController = TextEditingController();
  final _courseController = TextEditingController();
  final _dateController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedPriority = 'Medium';

  final Color navyBackground = const Color(0xFF1A233A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navyBackground, // Changed background
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          color: navyBackground,
          padding: const EdgeInsets.only(left: 10, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
                label: const Text(
                  "Back",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 5),
                child: Text(
                  "Create Assignment",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // The Separator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: Colors.white.withValues(alpha: 0.15),
              thickness: 1,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Assignment Title"),
                  _buildTextField(
                    _titleController,
                    "e.g., Introduction to Leadership",
                  ),

                  const SizedBox(height: 20),
                  _buildLabel("Course Name"),
                  _buildTextField(_courseController, "e.g., Mobile App Dev"),

                  const SizedBox(height: 20),
                  _buildLabel("Due Date"),
                  _buildTextField(
                    _dateController,
                    "mm/dd/yyyy",
                    suffixIcon: Icons.calendar_today_outlined,
                  ),

                  const SizedBox(height: 20),
                  _buildLabel("Priority Level"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildPriorityBtn("Low"),
                      const SizedBox(width: 10),
                      _buildPriorityBtn("Medium"),
                      const SizedBox(width: 10),
                      _buildPriorityBtn("High"),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _buildLabel("Description (Optional)"),
                  _buildTextField(
                    _descController,
                    "Add any notes or details...",
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                _buildActionButton(
                  "Create Assignment",
                  const Color(0xFFFFC107),
                  navyBackground,
                  () => Navigator.pop(context),
                ),
                const SizedBox(height: 10),
                _buildActionButton(
                  "Cancel",
                  Colors.transparent, // Clean look on dark background
                  Colors.white70,
                  () => Navigator.pop(context),
                  hasBorder: true,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    IconData? suffixIcon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white), // User input text
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: Colors.white70)
            : null,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05), // Subtle dark input
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
      ),
    );
  }

  Widget _buildPriorityBtn(String label) {
    bool isSelected = _selectedPriority == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFFFFC107)
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? const Color(0xFFFFC107) : Colors.white12,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? navyBackground : Colors.white70,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String text,
    Color bg,
    Color textCol,
    VoidCallback onPressed, {
    bool hasBorder = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: textCol,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: hasBorder
                ? BorderSide(color: Colors.white.withValues(alpha: 0.2))
                : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
