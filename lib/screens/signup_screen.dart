import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  // Validation error messages
  String _emailError = '';
  String _passwordError = '';

  // Validate email format
  bool _isValidEmail(String email) {
    return email.contains('@') && email.contains('.') && email.length > 5;
  }

  // Validate strong password
  bool _isStrongPassword(String password) {
    // Password must be at least 8 characters
    if (password.length < 8) return false;

    // Must contain at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) return false;

    // Must contain at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) return false;

    // Must contain at least one number
    if (!password.contains(RegExp(r'[0-9]'))) return false;

    // Must contain at least one special character
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;

    return true;
  }

  // Get password strength message
  String _getPasswordStrengthMessage(String password) {
    if (password.isEmpty) return '';

    List<String> missing = [];

    if (password.length < 8) missing.add('at least 8 characters');
    if (!password.contains(RegExp(r'[A-Z]')))
      missing.add('one uppercase letter');
    if (!password.contains(RegExp(r'[a-z]')))
      missing.add('one lowercase letter');
    if (!password.contains(RegExp(r'[0-9]'))) missing.add('one number');
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')))
      missing.add('one special character');

    if (missing.isEmpty) return 'Strong password ✓';

    return 'Password needs: ${missing.join(', ')}';
  }

  void _handleSignUp() {
    // Reset error messages
    setState(() {
      _emailError = '';
      _passwordError = '';
    });

    // Validate email
    if (_emailController.text.trim().isEmpty) {
      setState(() {
        _emailError = 'Email is required';
      });
      return;
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      setState(() {
        _emailError = 'Please enter a valid email address';
      });
      return;
    }

    // Validate password
    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
      return;
    }

    if (!_isStrongPassword(_passwordController.text)) {
      setState(() {
        _passwordError = _getPasswordStrengthMessage(_passwordController.text);
      });
      return;
    }

    // Save user credentials
    _authService.saveUser(
      _emailController.text.trim(),
      _passwordController.text,
    );

    // Show success message and navigate to login
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text(
          'Account created successfully!\n\nPlease log in with your credentials.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),

                // App Logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.person_add,
                    size: 50,
                    color: Color(0xFF0A1F44),
                  ),
                ),

                const SizedBox(height: 24),

                // Title
                const Text(
                  'Sign-Up here',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 40),

                // Student Sign-Up Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Student Sign-Up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0A1F44),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // University Email Field
                      const Text(
                        'University Email',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          // Clear error when user starts typing
                          if (_emailError.isNotEmpty) {
                            setState(() {
                              _emailError = '';
                            });
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                      // Email error message
                      if (_emailError.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4, left: 4),
                          child: Text(
                            _emailError,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 232, 61, 49),
                              fontSize: 12,
                            ),
                          ),
                        ),

                      const SizedBox(height: 16),

                      // Password Field
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        onChanged: (value) {
                          // Update password strength message in real-time
                          setState(() {
                            if (_passwordError.isNotEmpty) {
                              _passwordError = '';
                            }
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                      // Password strength indicator
                      if (_passwordController.text.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4, left: 4),
                          child: Text(
                            _getPasswordStrengthMessage(
                              _passwordController.text,
                            ),
                            style: TextStyle(
                              color: _isStrongPassword(_passwordController.text)
                                  ? Colors.green
                                  : Colors.orange,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      // Password error message
                      if (_passwordError.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4, left: 4),
                          child: Text(
                            _passwordError,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Sign Up Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC107), // Yellow color
                      foregroundColor: const Color(0xFF0A1F44),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Go to Login Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Already have an account? Login',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
