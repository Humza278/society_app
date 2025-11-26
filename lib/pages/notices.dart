import 'package:flutter/material.dart';

class NoticePage extends StatelessWidget {
  final List<Map<String, String>> notices = [
    {
      "title": "Water Supply Off",
      "description":
          "Water supply will remain suspended from 2PM–6PM for pipeline work.",
      "date": "20 Nov",
    },
    {
      "title": "Gym Closed",
      "description": "The gym is under renovation for the next 14 days.",
      "date": "18 Nov",
    },
    {
      "title": "Community Meetup",
      "description":
          "Annual society meetup at the central park. All residents invited!",
      "date": "15 Nov",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
        child: Column(
          children: [
                            // Header
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    "Notices/Annoucement",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
        
            const SizedBox(height: 20),
        
            // Top Image
            Image.asset(
              "lib/images/blackboard.png",
              width: 250,
              height: 150,
              fit: BoxFit.contain,
            ),
        
            const SizedBox(height: 25),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.all(16),
                          itemCount: notices.length,
                          itemBuilder: (context, index) {
                            var item = notices[index];
                        
                            return Container(
                              margin: EdgeInsets.only(bottom: 18),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.black87, // Blackboard color
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.7),
                                  width: 2.5, // Chalk border
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    offset: Offset(0, 6),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                        
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Notice Title
                                  Text(
                                    item["title"]!,
                                    style: TextStyle(
                                      fontFamily: "Chalk",
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 3,
                                          color: Colors.white24, // Chalk smudge
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                        
                                  SizedBox(height: 10),
                        
                                  // Notice Description
                                  Text(
                                    item["description"]!,
                                    style: TextStyle(
                                      fontFamily: "Chalk",
                                      fontSize: 16,
                                      color: Colors.white70,
                                      height: 1.4,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 4,
                                          color: Colors.white24, // Chalk smudge
                                        ),
                                      ],
                                    ),
                                  ),
                        
                                  SizedBox(height: 15),
                        
                                  // Date (chalk style)
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.7),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        item["date"]!,
                                        style: TextStyle(
                                          fontFamily: "Chalk",
                                          color: Colors.white,
                                          fontSize: 14,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
