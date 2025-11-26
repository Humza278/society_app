import 'package:flutter/material.dart';
import 'package:society_app/pages/utility_service.dart';
import 'package:society_app/tab/facility_tab.dart';
import '../../tab/bill_card.dart';

class ServiceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // <-- FIX: makes whole page scrollable
      child: Column(

        children: [
          Padding(
          padding: const EdgeInsets.all(12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff2193b0),
                    Color(0xff6dd5ed),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

          // ---------------- WELCOME TEXT ----------------
          Text(
            "Welcome Humza",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 15),

          // ---------------- BILL ROW ----------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Billcard(
                title: "Electric Bill",
                icon: Icons.flash_on_rounded,
                iconColor: Colors.orangeAccent,
                dueDate: "00-00-0000",
              ),
              Billcard(
                title: "Gas Bill",
                icon: Icons.local_fire_department_rounded,
                iconColor: Colors.redAccent,
                dueDate: "00-00-0000",
              ),
              Billcard(
                title: "Water Bill",
                icon: Icons.water_drop_rounded,
                iconColor: Colors.blueAccent,
                dueDate: "00-00-0000",
              ),
            ],
          ),
        ],
      ),
    ),
  ),
),


          
          // -------------------- SERVICE ICON ROW --------------------
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => UtilityService()),
                      );
                    },
                    child: serviceIcon("lib/images/maintenance.png", "Utility")),
                  serviceIcon("lib/images/electrician.png", "Electrician"),
                  serviceIcon("lib/images/freelance.png", "Internet"),
                  serviceIcon("lib/images/janitorial-service.png","Janitorial",
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),
          // Services 
          // Padding(
          //   padding: const EdgeInsets.all(12.0),
          //   child: Column(
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           Container(
          //             padding: EdgeInsets.all(12),
          //            decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(12),
          //             color: const Color.fromARGB(255, 241, 243, 244),
          //             boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.grey.withValues(alpha: 0.5),
          //                   spreadRadius: 1,
          //                   blurRadius: 4,
          //                   offset: Offset(0, 0), // changes position of shadow
          //                 ),
          //               ],
          //            ),
          //            child: Row(
          //             children: [
          //               Image.asset('lib/images/maintenance.png',width: 35,height: 30,),
          //               // Icon(Icons.sell_rounded),
          //               SizedBox(width: 10,),
          //               Text("Utility service",style: TextStyle(fontWeight: FontWeight.bold),)
          //             ],
          //            ),
          //           ),
          //           Container(
          //             padding: EdgeInsets.all(12),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(12),
          //               color: const Color.fromARGB(255, 241, 243, 244),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.grey.withValues(alpha: 0.5),
          //                   spreadRadius: 1,
          //                   blurRadius: 4,
          //                   offset: Offset(0, 0), // changes position of shadow
          //                 ),
          //               ],
          //             ),
          //             child: Row(
          //               children: [
          //                 Image.asset(
          //                   'lib/images/electrician.png',
          //                   width: 35,
          //                   height: 30,
          //                 ),
          //                 // Icon(Icons.sell_rounded),
          //                 SizedBox(width: 10),
          //                 Text(
          //                   "Electrician",
          //                   style: TextStyle(fontWeight: FontWeight.bold),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
                
          //       SizedBox(height: 20,),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           Container(
          //             padding: EdgeInsets.all(12),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(12),
          //               color: const Color.fromARGB(255, 241, 243, 244),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.grey.withValues(alpha: 0.5),
          //                   spreadRadius: 1,
          //                   blurRadius: 4,
          //                   offset: Offset(0, 0), // changes position of shadow
          //                 ),
          //               ],
          //             ),
          //             child: Row(
          //               children: [
          //                 Image.asset(
          //                   'lib/images/freelance.png',
          //                   width: 35,
          //                   height: 30,
          //                 ),
          //                 // Icon(Icons.sell_rounded),
          //                 SizedBox(width: 10),
          //                 Text(
          //                   "Internet",
          //                   style: TextStyle(fontWeight: FontWeight.bold),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Container(
          //             padding: EdgeInsets.all(12),
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(12),
          //               color: const Color.fromARGB(255, 241, 243, 244),
          //               boxShadow: [
          //                 BoxShadow(
          //                   color: Colors.grey.withValues(alpha: 0.5),
          //                   spreadRadius: 1,
          //                   blurRadius: 4,
          //                   offset: Offset(0, 0), // changes position of shadow
          //                 ),
          //               ],
          //             ),
          //             child: Row(
          //               children: [
          //                 Image.asset(
          //                   'lib/images/janitorial-service.png',
          //                   width: 35,
          //                   height: 30,
          //                 ),
          //                 // Icon(Icons.sell_rounded),
          //                 SizedBox(width: 10),
          //                 Text(
          //                   "Janitorial",
          //                   style: TextStyle(fontWeight: FontWeight.bold),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
                
          //     ],
          //   ),
          // ),

          // -------------------- FACILITY BOOKING CARD --------------------
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 15,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // background image
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("lib/images/facility.png"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.45),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),

                    // gradient + content
                    Container(
                      height: 200,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.1),
                          ],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // LEFT TEXT
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Facility",
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Booking",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                width: 120,
                                child: Divider(
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),

                          // BOOK NOW BUTTON
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => FacilityBookingPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: const Text(
                              "Book Now",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  // REUSABLE SERVICE ICON FUNCTION
  Widget serviceIcon(String img, String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
            ),
            child: Image.asset(img, width: 40, height: 40),
          ),
          SizedBox(height: 4),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
