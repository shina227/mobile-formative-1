import 'package:flutter/material.dart';
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/attendance_tracking_screen.dart';

void main() {
  runApp(const ALUStudentApp());
}

class ALUStudentApp extends StatelessWidget {
  const ALUStudentApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALU Student Assistant App',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 5, 17, 39),
        scaffoldBackgroundColor: const Color(0xFF0A1F44),
        fontFamily: 'Roboto',
      ),
      home: const SignupScreen(),
      routes: {'/login': (context) => const LoginScreen()},
      debugShowCheckedModeBanner: false,
    );
  }
}
