import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:society_app/pages/contact_us.dart';
import 'package:society_app/views/home_screen2.dart';
import '../views/login_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  // late int _currentIndex; // FIXED → internal variable

    int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage2(),
    ContactUsPage(),
    ContactUsPage(),
    ContactUsPage(),
    ContactUsPage(),
  ];


  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex; // set initial index
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffa8edea), Color(0xfffed6e3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            navItem(Icons.home_outlined, "Home", 0),
            navItem(Icons.shopping_bag_outlined, "Shop", 1),
            navItem(Icons.edit_document, "Documents", 2),
            navItem(Icons.phone, "Contact Us", 3),
            navItem(Icons.person_outline, "Account", 4),
          ],
        ),
      ),
    );
  }
  Widget navItem(IconData icon, String label, int index) {
    final bool isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: isActive
            ? BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              )
            : null,
        child: Row(
          children: [
            Icon(icon, color: isActive ? Colors.white : Colors.black, size: 26),
            if (isActive) ...[
              SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


