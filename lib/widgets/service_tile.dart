import 'package:flutter/material.dart';
import '../views/services/service_request_page.dart';
import '../views/services/complaints_page.dart';
import '../views/services/bills_page.dart';
import '../views/services/notices_page.dart';
import '../views/services/visitor_logs_page.dart';
import '../views/services/facility_booking_page.dart';
import '../views/services/documents_page.dart';
import '../views/services/contact_us_page.dart';

class ServiceCard extends StatelessWidget {
  final List<Map<String, dynamic>> services = [
    {
      "name": "Service Request",
      "icon": Icons.miscellaneous_services,
      "page": ServiceRequestPage(),
    },
    {
      "name": "Complaints",
      "icon": Icons.report_problem,
      "page": ComplaintsPage(),
    },
    {"name": "Bills", "icon": Icons.receipt_long, "page": BillsPage()},
    {
      "name": "Notices",
      "icon": Icons.notifications_active,
      "page": NoticesPage(),
    },
    {
      "name": "Visitor Logs",
      "icon": Icons.people_alt,
      "page": VisitorLogsPage(),
    },
    {
      "name": "Facility Booking",
      "icon": Icons.event_available,
      "page": FacilityBookingPage(),
    },
    {"name": "Documents", "icon": Icons.folder_copy, "page": DocumentsPage()},
    {
      "name": "Contact Us",
      "icon": Icons.support_agent,
      "page": ContactUsPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // << ADD THIS
      physics: NeverScrollableScrollPhysics(), // << ADD THIS
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemBuilder: (context, index) {
        var item = services[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => item["page"]),
            );
          },
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item["icon"], size: 40, color: Colors.blueAccent),
                SizedBox(height: 10),
                Text(
                  item["name"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
