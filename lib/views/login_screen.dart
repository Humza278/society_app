import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/paint_drop.dart';
import 'package:http/http.dart' as http;
import 'home_screen.dart';
import 'home_screen2.dart';

import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

Future<void> loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setState(() => _isLoading = true);

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() => _isLoading = false);

    // Dummy data
    const dummyEmail = 'user@example.com';
    const dummyPassword = '123456';
    const dummyStatus = 'approved'; // try also 'pending'

    if (email == email && password == password) {
      if (dummyStatus == 'approved') {

              /// SAVE LOGIN STATUS + LOGIN TIME
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isLoggedIn", true);
        await prefs.setString("loginTime", DateTime.now().toIso8601String());
        await prefs.setString("userEmail", email);
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomePage2()),
        );
      } else if (dummyStatus == 'pending') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Your status is pending. Please wait.')),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid credentials.')));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const PaintDropBackground(), // your glowing paint background
          SafeArea(
            child: Column(
              children: [
                // Top-right Sign Up button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: const Duration(
                                milliseconds: 700,
                              ),
                              pageBuilder: (_, __, ___) =>
                                  const RegisterScreen(),
                              transitionsBuilder: (_, animation, __, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.person_add,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Sign In heading
                const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 20),

                // Card form
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade100,
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty)
                              return 'Email is required';
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(v))
                              return 'Enter a valid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          validator: (v) => v == null || v.isEmpty
                              ? 'Password is required'
                              : null,
                        ),
                        const SizedBox(height: 25),

                        // Login button with loading indicator
                        _isLoading
                            ? const CircularProgressIndicator()
                            : CustomButton(text: 'Login', onPressed: loginUser),
                      ],
                    ),
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
