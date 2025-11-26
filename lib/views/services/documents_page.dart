import 'package:flutter/material.dart';

class DocumentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Documents")),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ListTile(title: Text("Tenant Agreement")),
          ListTile(title: Text("Other Documents")),
        ],
      ),
    );
  }
}
