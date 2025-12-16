import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'otp_screen.dart';

/// ------------------ SOCIETY MODEL ------------------
class Society {
  final int id;
  final String name;

  Society({required this.id, required this.name});

  factory Society.fromJson(Map<String, dynamic> json) {
    return Society(id: json['id'], name: json['name']);
  }
}

/// ------------------ REGISTER SCREEN ------------------
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();

  List<Society> societies = [];
  Society? selectedSociety;
  bool loadingSocieties = true;
  bool isLoading = false;

  double? latitude;
  double? longitude;
  String address = "";

  @override
  void initState() {
    super.initState();
    fetchSocieties();
  }

  /// ------------------ FETCH SOCIETIES ------------------
  Future<void> fetchSocieties() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.crystalfms.com/api/v1/societies'),
      );
      final data = jsonDecode(response.body);

      if (data['status'] == true) {
        societies = (data['data'] as List)
            .map((e) => Society.fromJson(e))
            .toList();
      }
    } finally {
      if (mounted) setState(() => loadingSocieties = false);
    }
  }

  /// ------------------ LOCATION ------------------
  Future<void> _getLocationAndAddress() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever)
        return;

      final position = await Geolocator.getCurrentPosition();
      latitude = position.latitude;
      longitude = position.longitude;

      final placemarks = await placemarkFromCoordinates(latitude!, longitude!);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        address = "${p.street}, ${p.locality}, ${p.country}";
      }
    } catch (_) {}
  }

  /// ------------------ REGISTER ------------------
  Future<void> registerUser() async {
    if (!_formKey.currentState!.validate()) return;
    if (selectedSociety == null) {
      _showMessage('Please select a society');
      return;
    }

    setState(() => isLoading = true);

    try {
      await _getLocationAndAddress();

      final response = await http.post(
        Uri.parse('https://api.crystalfms.com/api/v1/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "branch_id": selectedSociety!.id,
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "phone": phoneController.text.trim(),
          "password": passwordController.text.trim(),
          "lat": latitude?.toString() ?? "",
          "long": longitude?.toString() ?? "",
          "address": addressController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 409) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => OtpScreen(
              userId: data['user_id'], // nullable-safe in OTP
              email: emailController.text.trim(),
            ),
          ),
        );
      } else {
        _showMessage(data['message'] ?? 'Registration failed');
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  /// ------------------ UI ------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            color: Colors.white,
            child: Column(
              children: [
                _header(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _input(nameController, 'Full Name', Icons.person),
                          _input(emailController, 'Email Address', Icons.mail),
                          _phoneField(),
                          _societyDropdown(),
                          _input(addressController, 'Resident Address', Icons.location_on_outlined),
                          _input(
                            passwordController,
                            'Password',
                            Icons.lock,
                            obscure: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                _bottomButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 80,
            width: 80,
            // decoration: BoxDecoration(
            //   color: const Color.fromARGB(255, 216, 220, 224).withOpacity(.1),
            //   borderRadius: BorderRadius.circular(16),
            // ),
            child: Image.asset("lib/images/Crystal FMS.png")
          ),
          const SizedBox(height: 16),
          const Text(
            'Create Account',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter your details to connect with your society.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _input(
    TextEditingController c,
    String label,
    IconData icon, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: c,
        obscureText: obscure,
        validator: (v) => v == null || v.isEmpty ? '$label required' : null,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(icon,color: Colors.blue,),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          )
        ),
      ),
    );
  }

  Widget _phoneField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(14),
              ),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Center(child: Text('03')),
          ),
          Expanded(
            child: TextFormField(
              controller: phoneController,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Phone required' : null,
              decoration: const InputDecoration(
                hintText: '00 000 0000',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _societyDropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: loadingSocieties
          ? const CircularProgressIndicator()
          : DropdownButtonFormField<Society>(
              value: selectedSociety,
              isExpanded: true, // 🔑 MOST IMPORTANT
              validator: (v) => v == null ? 'Society required' : null,
              decoration: InputDecoration(
                labelText: 'Select Society',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
              ),

              // 🔑 Fix selected item overflow
              selectedItemBuilder: (context) {
                return societies.map((s) {
                  return Text(
                    s.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  );
                }).toList();
              },

              items: societies.map((s) {
                return DropdownMenuItem<Society>(
                  value: s,
                  child: Text(
                    s.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                );
              }).toList(),

              onChanged: (v) => setState(() => selectedSociety = v),
            ),
    );
  }


  Widget _bottomButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF138AEC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: isLoading ? null : registerUser,
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  'Register Now',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                ),
        ),
      ),
    );
  }
}
