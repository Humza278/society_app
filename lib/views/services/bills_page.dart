import 'package:flutter/material.dart';

class BillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bills")),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ListTile(title: Text("Maintenance Bill")),
          ListTile(title: Text("Electric Bill")),
          ListTile(title: Text("Gas Bill")),
          ListTile(title: Text("KWS&B Bill")),
        ],
      ),
    );
  }
}
