import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class AssignmentsScreen extends StatelessWidget {
  const AssignmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: const Center(
        child: Text(
          "Assignments Screen",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
