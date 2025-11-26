import 'package:flutter/material.dart';

class ServiceRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Service Request")),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ListTile(title: Text("Utility Services")),
          ListTile(title: Text("Electrician / Plumber / Carpenter")),
          ListTile(title: Text("TV Cable / Internet")),
          ListTile(title: Text("Water Bottle Delivery")),
          ListTile(title: Text("Janitorial Services")),
        ],
      ),
    );
  }
}
