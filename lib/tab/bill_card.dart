import 'package:flutter/material.dart';

class Billcard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String dueDate;
  
  const Billcard({
    super.key,
    required  this.title,
    required  this.icon,
    required  this.iconColor,
    required  this.dueDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                    fontSize: 13,
                  ),
                ),
              ),
              Icon(icon, size: 20, color: iconColor),
            ],
          ),

          SizedBox(height: 10),

          Text(
            "Due Date:",
            style: TextStyle(
              fontSize: 11,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            dueDate,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
