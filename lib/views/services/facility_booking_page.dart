import 'package:flutter/material.dart';

class FacilityBookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Facility Booking")),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ListTile(title: Text("Community Hall")),
          ListTile(title: Text("Swimming Pool")),
          ListTile(title: Text("Gym")),
        ],
      ),
    );
  }
}
