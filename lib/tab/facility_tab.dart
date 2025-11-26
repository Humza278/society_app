import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class FacilityBookingPage extends StatefulWidget {
  @override
  _FacilityBookingPageState createState() => _FacilityBookingPageState();
}

class _FacilityBookingPageState extends State<FacilityBookingPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,

      body: SafeArea(
        child: Column(
          children: [
            // ---------- DARK CALENDAR CARD ----------
            Container(
              // margin: EdgeInsets.all(16),
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // MONTH + MENU
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu, color: Colors.blue),
                      Text(
                        "JANUARY",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down, color: Colors.white),
                    ],
                  ),
        
                  SizedBox(height: 20),
        
                  // CALENDAR
                  TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 1, 1),
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selected, focused) {
                      setState(() {
                        _selectedDay = selected;
                        _focusedDay = focused;
                      });
                    },
                    headerVisible: false,
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.white70),
                      weekendStyle: TextStyle(color: Colors.white70),
                    ),
                    calendarStyle: CalendarStyle(
                      defaultTextStyle: TextStyle(color: Colors.white),
                      weekendTextStyle: TextStyle(color: Colors.white),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                      todayDecoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),


            // ---------- WHITE BOTTOM CARD ----------
            Expanded(
              child: 
              Container(
                 width: double.infinity,
                 padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(height: 4, width: 80, color: Colors.black),
                        Column(
                          children: [
                            Text(
                              _selectedDay!.day.toString().padLeft(2, '0'),
                              style: TextStyle(
                                fontSize: 85,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _dayName(_selectedDay!),
                              style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                        
                      ],
                    ),
                    SizedBox(height: 50,),
                     // FACILITY BOOKINGS LIST
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 85,vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300
                            ),
                            child: Text("Tennis Court",style: TextStyle(fontSize: 16),))

                          // bookingItem("Tennis Court (4–5 PM)"),
                          // bookingItem("Swimming Pool (6–7 PM)"),
                          // bookingItem("Community Hall (7–8 PM)"),
                          // bookingItem("Meeting Room (9–10 PM)"),
                        ],
                      ),
                    ),
                  ],
                ),

            )
            ),
        
            // ---------- WHITE BOTTOM CARD ----------
            // Expanded(
            //   child: Container(
            //     width: double.infinity,
            //     // margin: EdgeInsets.symmetric(horizontal: 16),
            //     padding: EdgeInsets.all(20),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(22),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black12,
            //           blurRadius: 15,
            //           offset: Offset(0, 6),
            //         ),
            //       ],
            //     ),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         // BIG DATE
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Container(height: 4, width: 80, color: Colors.black),
            //             Text(
            //               _selectedDay!.day.toString().padLeft(2, '0'),
            //               style: TextStyle(
            //                 fontSize: 85,
            //                 color: Colors.blue,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             Text(
            //               _dayName(_selectedDay!),
            //               style: TextStyle(
            //                 fontSize: 16,
            //                 letterSpacing: 1,
            //                 color: Colors.grey[800],
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             SizedBox(height: 10),
            //             Container(height: 4, width: 50, color: Colors.black),
            //           ],
            //         ),
        
            //         SizedBox(width: 25),
        
            //         // FACILITY BOOKINGS LIST
            //         Expanded(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               bookingItem("Tennis Court (4–5 PM)"),
            //               bookingItem("Swimming Pool (6–7 PM)"),
            //               bookingItem("Community Hall (7–8 PM)"),
            //               bookingItem("Meeting Room (9–10 PM)"),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),

      // Floating Add Button
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 10)],
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {},
          child: Icon(Icons.add, size: 32,color: Colors.white,),
        ),
      ),
    );
  }

  Widget bookingItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(text, style: TextStyle(fontSize: 15, color: Colors.black87)),
    );
  }

  String _dayName(DateTime date) {
    return [
      "SUNDAY",
      "MONDAY",
      "TUESDAY",
      "WEDNESDAY",
      "THURSDAY",
      "FRIDAY",
      "SATURDAY",
    ][date.weekday % 7];
  }
}
