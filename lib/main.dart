import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/attendance_tracking_screen.dart';

void main() {
  runApp(const ALUStudentApp());
}

class ALUStudentApp extends StatelessWidget {
  const ALUStudentApp({Key? key}) : super(key: key);
=======
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
>>>>>>> 3a9ec57fa4ad61933d86eb94e347d392427db078

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      title: 'ALU Student Assistant App',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 5, 17, 39),
        scaffoldBackgroundColor: const Color(0xFF0A1F44),
        fontFamily: 'Roboto',
      ),
      home: const SignupScreen(),
      routes: {'/login': (context) => const LoginScreen()},
      debugShowCheckedModeBanner: false,
=======
      title: 'ALU Academic Assistant',
      debugShowCheckedModeBanner: false,
      home: const DashboardScreen(),
>>>>>>> 3a9ec57fa4ad61933d86eb94e347d392427db078
    );
  }
}
