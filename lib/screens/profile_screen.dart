import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: const Center(
        child: Text(
          "Profile Screen",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
