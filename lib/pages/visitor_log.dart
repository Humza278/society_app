import 'dart:ui';
import 'package:flutter/material.dart';

class VisitorLogPage extends StatelessWidget {
  final List<Map<String, String>> visitorData = [
    {
      "name": "Ali Raza",
      "cnic": "35202-1234567-8",
      "timeIn": "09:10 AM",
      "timeOut": "11:30 AM",
    },
    {
      "name": "Ayesha Khan",
      "cnic": "42101-4567890-2",
      "timeIn": "10:00 AM",
      "timeOut": "—",
    },
    {
      "name": "Hamza",
      "cnic": "36302-7894561-2",
      "timeIn": "08:45 AM",
      "timeOut": "12:20 PM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Visitor Log",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: visitorData.length,
          itemBuilder: (context, index) {
            final data = visitorData[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          spreadRadius: 3,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name Row
                        Row(
                          children: [
                            Icon(Icons.person, size: 26, color: Colors.black87),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                data["name"]!,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 10),

                        // CNIC Row
                        Row(
                          children: [
                            Icon(Icons.badge, color: Colors.black54),
                            SizedBox(width: 10),
                            Text(data["cnic"]!, style: TextStyle(fontSize: 16)),
                          ],
                        ),

                        SizedBox(height: 10),

                        // Time rows
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.login, color: Colors.green[700]),
                                SizedBox(width: 6),
                                Text(
                                  data["timeIn"]!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.logout, color: Colors.red[700]),
                                SizedBox(width: 6),
                                Text(
                                  data["timeOut"]!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
