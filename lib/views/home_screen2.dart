import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:society_app/pages/contact_us.dart';
import 'package:society_app/views/util/my_tab.dart';
import 'package:society_app/widgets/custom_bottom_nav_bar.dart';

import '../pages/utility_service.dart';
import '../tab/bill_tab.dart';
import '../tab/complaint_tab.dart';
import '../tab/document_tab.dart';
import '../tab/facility_tab.dart';
import '../tab/notice_tab.dart';
import '../tab/service_tab.dart';
import '../tab/visitor_tab.dart';
import 'login_screen.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text("Home Page")),
    const Center(child: Text("Search Page")),
    const Center(child: Text("Add New Post")),
    const Center(child: Text("Likes Page")),
    const Center(child: Text("Profile Page")),
  ];

  String userName = "";
  String userEmail = "";
  String userPhone = "";
  String userAddress = "";

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString("name") ?? "";
      userEmail = prefs.getString("email") ?? "";
      userPhone = prefs.getString("phone") ?? "";
      userAddress = prefs.getString("address") ?? "";
    });
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }
  // my tabs
  List<Widget> myTabs = [
    // service tab
    MyTab(tabImage: "lib/images/house.png",tabName: "Home",),

    //complaints tab
    MyTab(tabImage: "lib/images/angry-customer.png", tabName: "Complaints"),

    //bills tab
    MyTab(tabImage: "lib/images/visitor.png", tabName: "Visitor Logs"),

  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: Colors.black, // Set your desired color here
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child: Center(child: Text("L O G O",style: TextStyle(fontSize: 40)))),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
                onTap: (){

                },
              ),
              ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text("Logout"),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                },
              ),
            ],
          ), 
        ),
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 24),
            
                //tab bar
                TabBar(
                  isScrollable: true,
                  labelPadding: EdgeInsets.symmetric(horizontal: 25),
                  indicatorColor: Colors.blue,
                  tabs: myTabs),
            
                //tab bar view
                Expanded(
                  child: TabBarView(
                    children: [
                      //service page
                      ServiceTab(),
            
                      //complaints page
                      ComplaintTab(),
            
            
                      // Notices/announcement page
                      // NoticeTab(),
            
                      // // vistor page
                      VisitorScreen(),
            
                      // // Facility Booking page
                      // FacilityTab(),
            
                      // // Documents page
                      // DocumentTab(),
            
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25, right: 25),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ContactUsPage()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.lightGreenAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Icon(Icons.phone, size: 28),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
          ],

        ),
         bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
