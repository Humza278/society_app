import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'register_screen.dart';
import 'home_screen2.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  /// ---------------- LOGIN API ----------------
  Future<void> loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("https://api.crystalfms.com/api/v1/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["status"] == "success") {
        final loginStatus = data["loginStatus"];
        final token = data["token"];
        final user = data["UserDetail"];

        if (loginStatus == "active") {
          final prefs = await SharedPreferences.getInstance();

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

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomePage2()),
          );
        } else {
          _showSnack("Your account is pending approval.");
        }
      } else {
        _showSnack(data["message"] ?? "Invalid credentials");
      }
    } catch (e) {
      _showSnack("Something went wrong");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  /// ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7F8),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              children: [
                /// HEADER IMAGE
                Container(
                  margin: const EdgeInsets.all(16),
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuDTCJlNNKicq9IP7XdjmMI0q52FrGRIwH_6FAv65LZ_-97KhQjlPOhi7_g4P4jQr2PRrVby6nMWHPefJXnm0W8UxzETaex3qliQnCFASlG2k2frxMjYuvjImX0qQpQxYljwubEt3W4MKnspg-oVWyAZqy-zH8DiY9RFneK6A5by95Xs0_IXHZhBH0MQAXp-O5eVb99EOIcVoE181h3zx_apTGKa4Nfjycb0I7YQc1NT_053QL4iLl6BqmDmG1e9OKquZBrr9Wwks6c",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.all(12),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset("lib/images/Crystal FMS.png",width: 50,height: 50,),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
      
                /// TITLE
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Home",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "Log in to manage your residence.",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                /// FORM
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        /// EMAIL
                        _inputField(
                          controller: emailController,
                          hint: "Enter your Register Email Address",
                          icon: Icons.person,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Email is required";
                            }
                            return null;
                          },
                        ),
      
                        const SizedBox(height: 14),
      
                        /// PASSWORD
                        _inputField(
                          controller: passwordController,
                          hint: "Password",
                          icon: Icons.lock,
                          obscure: _obscurePassword,
                          suffix: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? "Password required" : null,
                        ),
      
                        const SizedBox(height: 20),
      
                        /// LOGIN BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : loginUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF138AEC),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Log In",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                          ),
                        ),
      
                        const SizedBox(height: 20),
      
                        /// SIGN UP
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("New resident? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Request access",
                                style: TextStyle(
                                  color: Color(0xFF138AEC),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ---------------- INPUT FIELD ----------------
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
