import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/login_screen.dart';



class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  const CustomBottomNavBar({super.key,required this.selectedIndex,required this.onItemTapped});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _currentIndex; // FIXED → internal variable
    @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex; // set initial index
  }
 
 

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 0,
          offset: Offset(0, -4)
        )]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) async {
            if (index == 4) {
              // Logout tapped
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );

              return;
            }

            setState(() {
              _currentIndex = index;
            });

            widget.onItemTapped(index);
          },
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey[500],
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search),
              label: 'Search',
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle),
              label: 'Add',
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile',
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              activeIcon: Icon(Icons.logout),
              label: 'Logout',
            )
                
          ],
        
          ),
      ),
    );
  }
}
