import 'package:flutter/material.dart';

class ComplaintsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complaints")),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ListTile(title: Text("Janitorial Complaint")),
          ListTile(title: Text("Security Complaint")),
          ListTile(title: Text("Lift / Elevator Issue")),
          ListTile(title: Text("Parking Issue")),
          ListTile(title: Text("Staff Complaint")),
        ],
      ),
    );
  }
}
