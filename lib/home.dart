import 'package:flutter/material.dart';
import 'widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  final String name;

  HomePage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Waste Less Assistant"),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome,",
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 4),
            Text(
              "$name!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 40),
            CustomButton(
              text: "Add Item",
              color: Colors.green,
              icon: Icons.add_box,
              onTap: () {
                // navigate to add item screen
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: "View Items",
              color: Colors.orange,
              icon: Icons.list_alt,
              onTap: () {
                // navigate to items list screen
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: "Logout",
              color: Colors.red,
              icon: Icons.logout,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
