import 'package:flutter/material.dart';

class CommunityServiceTile extends StatefulWidget {
  const CommunityServiceTile({super.key});

  @override
  State<CommunityServiceTile> createState() => _CommunityServiceTileState();
}

class _CommunityServiceTileState extends State<CommunityServiceTile> {
  final List<Map<String, dynamic>> serviceList = [
    {
      "title": "Utility Services",
      "subtitle": "Water, Electric, Gas",
      "image": "lib/images/tools.png",
      "color": Colors.red,
    },
    {
      "title": "Technician",
      "subtitle": "Electrician, Plumber, Carpenter",
      "image": "lib/images/electrician.png",
      "color": Colors.orange,
    },
    {
      "title": "Cable / Internet",
      "subtitle": "TV Cable & Internet Support",
      "image": "lib/images/freelance.png",
      "color": Colors.green,
    },
    {
      "title": "Janitorial",
      "subtitle": "Cleaning & Garbage Service",
      "image": "lib/images/janitorial-service.png",
      "color": Colors.purple,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titles
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            "Community Services",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Text(
            "Services that are offered by society",
            style: TextStyle(color: Colors.grey[600], fontSize: 15),
          ),
        ),

        const SizedBox(height: 10),

        // Dynamic ListView
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: serviceList.length,
          itemBuilder: (context, index) {
            final item = serviceList[index];

            return GestureDetector(
              onTap: () {
                print("Clicked: ${item['title']}");
                // Navigate to page
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: item["color"].withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text details
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              item["subtitle"],
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),

                        // Service image
                        Image.asset(
                          item["image"],
                          width: 80,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}