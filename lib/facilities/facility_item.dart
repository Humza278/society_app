import 'package:flutter/material.dart';

class FacilityItem extends StatelessWidget {
  final String title;

  const FacilityItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // full width
      alignment: Alignment.centerRight, // push grey box to the right
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 75, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(title, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

