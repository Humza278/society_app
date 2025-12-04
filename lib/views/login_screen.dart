import 'package:flutter/material.dart';
import 'register_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/paint_drop.dart';
import 'package:http/http.dart' as http;
import 'home_screen.dart';
import 'home_screen2.dart';
import 'dart:convert';

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

    try {
      final url = Uri.parse("https://api.crystalfms.com/api/v1/login");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      setState(() => _isLoading = false);

      final data = jsonDecode(response.body);
      // print(response.body);

      if (response.statusCode == 200 && data["status"] == "success") {
        final loginStatus = data["loginStatus"]; // "approved" OR "pending"
        final token = data["token"];
        final user = data["UserDetail"];

        if (loginStatus == "active") {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setBool("isLoggedIn", true);
          await prefs.setString("token", token);

          await prefs.setInt("userId", user["id"]);
          await prefs.setInt("branchId", user["branch_id"]);
          await prefs.setInt("roleId", user["role_id"]);

          await prefs.setString("name", user["name"]);
          await prefs.setString("email", user["email"]);
          await prefs.setString("phone", user["phone"]);
          await prefs.setString("address", user["address"]);
          await prefs.setString("status", user["status"]);

          await prefs.setString("loginTime", DateTime.now().toIso8601String());

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage2()),
          );
        } else if (loginStatus == "pending") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Your account is pending approval. Please wait."),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Invalid credentials")),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
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
