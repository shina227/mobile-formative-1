import 'package:flutter/material.dart';

class EditAssignment extends StatefulWidget {
  final String initialTitle;
  final String initialCourse;
  final String initialPriority;

  const EditAssignment({
    super.key,
    required this.initialTitle,
    required this.initialCourse,
    required this.initialPriority,
  });

  @override
  State<EditAssignment> createState() => _EditAssignmentState();
}

class _EditAssignmentState extends State<EditAssignment> {
  late TextEditingController _titleController;
  late TextEditingController _courseController;
  late String _selectedPriority;
  final Color navyBackground = const Color(0xFF1A233A);

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _courseController = TextEditingController(text: widget.initialCourse);
    _selectedPriority = widget.initialPriority;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navyBackground,
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
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                label: const Text(
                  "Back",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 5),
                child: Text(
                  "Edit Assignment",
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
                  _buildTextField(_titleController),
                  const SizedBox(height: 20),

                  _buildLabel("Course Name"),
                  _buildTextField(_courseController),
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
                  const SizedBox(height: 30),

                  // Danger Zone (Updated for Dark Mode)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.redAccent.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Danger Zone",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Once you delete this assignment, it cannot be recovered.",
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                            ),
                            label: const Text(
                              "Delete Assignment",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.redAccent),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildActionButton(
                  "Save Changes",
                  const Color(0xFFFFC107),
                  navyBackground,
                  () => Navigator.pop(context),
                ),
                const SizedBox(height: 10),
                _buildActionButton(
                  "Cancel",
                  Colors.transparent,
                  Colors.white70,
                  () => Navigator.pop(context),
                  hasBorder: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reuse Helper Widgets from Add Screen style
  Widget _buildLabel(String text) => Padding(
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

  Widget _buildTextField(TextEditingController controller) => TextField(
    controller: controller,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.05),
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

  Widget _buildPriorityBtn(String label) {
    bool isSelected = _selectedPriority == label;
    Color activeColor = (label == "High")
        ? Colors.redAccent
        : (label == "Medium" ? Colors.orange : Colors.green);

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? activeColor
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? activeColor
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.4),
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
