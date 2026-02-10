import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: const Center(
        child: Text(
          " Schedule Screen",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
