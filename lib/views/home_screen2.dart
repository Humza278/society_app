import 'package:flutter/material.dart';
import 'package:society_app/pages/contact_us.dart';
import 'package:society_app/views/util/my_tab.dart';

import '../pages/utility_service.dart';
import '../tab/bill_tab.dart';
import '../tab/complaint_tab.dart';
import '../tab/contact_tab.dart';
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
  // my tabs
  List<Widget> myTabs = [
    // service tab
    MyTab(tabImage: "lib/images/house.png",tabName: "Home",),

    //complaints tab
    MyTab(tabImage: "lib/images/angry-customer.png", tabName: "Complaints"),

    //bills tab
    MyTab(tabImage: "lib/images/visitor.png", tabName: "Visitor Logs"),

    // Notices/announcement tab
    // MyTab(tabImage: "lib/images/notice.png", tabName: "Notices"),

    // // vistor Tab
    // MyTab(tabImage: "lib/images/maintenance.png", tabName: "Visitor Logs"),

    // // Facility Booking
    // MyTab(tabImage: "lib/images/maintenance.png", tabName: "Facility Booking"),

    // // Documents
    // MyTab(tabImage: "lib/images/maintenance.png", tabName: "Documents "),

  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: IconButton(
              icon: Icon(Icons.menu, color: Colors.grey[800], size: 36),
              onPressed: () {
                // open drawer
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: GestureDetector(
                  onTap: () {
                        // open logout
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                  },
                  child: Image.asset(
                    'lib/images/logout.png', // Replace with your image asset path
                    width: 40, // Optional: Set desired width
                    height: 40, // Optional: Set desired height
                  ),
                ),
              // IconButton(
              //   icon: Icon(Icons.logout, color: Colors.grey[800], size: 36),
              //   onPressed: () {
              //     // open logout
              //     Navigator.pushAndRemoveUntil(
              //       context,
              //       MaterialPageRoute(builder: (_) => const LoginScreen()),
              //       (route) => false,
              //     );
              //   },
              // ),
            ),
          ],
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
                      VisitorTab(),
            
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
                          MaterialPageRoute(builder: (_) => ContactUs()),
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
      ),
    );
  }
}
