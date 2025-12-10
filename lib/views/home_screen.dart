import 'package:flutter/material.dart';
import 'package:society_app/pages/contact_us.dart';
import 'package:society_app/pages/notices.dart';
import 'package:society_app/tab/document_tab.dart';
import 'package:society_app/tab/facility_tab.dart';
import 'package:society_app/views/home_screen2.dart';
import 'package:society_app/views/services/documents_page.dart';
import 'package:society_app/widgets/custom_bottom_nav_bar.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  int _selectedIndex = 0;

  // Define the list of actual screens here, NOT inside the NavBar widget
  final List<Widget> _screens = [
    HomePage2(), // 0: Your actual home screen content
    NoticePage(), // 1: Shop Page (Placeholder)
    DocumentsScreen(), // 2: Documents Page (Placeholder)
    ContactUsPage(), // 4: Account Page (Placeholder)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // The currently selected page is displayed in the body
      body: _screens[_selectedIndex],

      // We use Padding for the bottomNavigationBar to match your design's margin/padding
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped, // Pass the function up to change the index
      ),
    );
  }
}
