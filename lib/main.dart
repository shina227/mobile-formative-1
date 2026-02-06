import 'package:flutter/material.dart';
import 'package:student_academic_platform/screens/assignments/assignments.dart';
import 'package:student_academic_platform/screens/assignments/add_assignment.dart';
import 'package:student_academic_platform/screens/assignments/edit_assignment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Academic Platform',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: AssignmentsScreen(),
    );
  }
}
