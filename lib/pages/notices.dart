import 'package:flutter/material.dart';

class NoticePage extends StatelessWidget {
  final List<Map<String, String>> notices = [
    {
      "title": "Announcement",
      "description":
          "Increasing maintenance to \$20 from next month due to security increments.",
      "postedBy": "Admin",
      "date": "19 AUG 05 : 30 PM",
    },
    {
      "title": "New Year celebration",
      "description":
          "New year gathering in Seven gen society’s hall on 3rd November.",
      "postedBy": "Admin",
      "date": "20 AUG 05 : 30 PM",
    },
    {
      "title": "Christmas party",
      "description":
          "Christmas will be celebrated on 23rd December, 2018 at our Society auditorium.",
      "postedBy": "Admin",
      "date": "22 DEC 08 : 30 PM",
    },
    {
      "title": "New Year celebration",
      "description":
          "New year gathering in Seven gen society’s hall on 3rd November.",
      "postedBy": "Admin",
      "date": "20 AUG 05 : 30 PM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back, size: 26),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Notice board",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            // Body
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                itemCount: notices.length,
                itemBuilder: (context, index) {
                  var item = notices[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 18),
                    padding: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // TITLE + NEW BADGE
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item["title"]!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                            ),

                            // NEW Badge
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                "New",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8),

                        // DESCRIPTION
                        Text(
                          item["description"]!,
                          style: TextStyle(
                            fontSize: 14.5,
                            color: Colors.black54,
                            height: 1.4,
                          ),
                        ),

                        SizedBox(height: 12),

                        Divider(color: Colors.grey.shade300),

                        SizedBox(height: 10),

                        // POSTED BY + DATE ROW
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Post by : ${item["postedBy"]}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              item["date"]!,
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black45,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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
    );
  }
}
