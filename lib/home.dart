import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String name; // user's name passed from login

  HomePage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Waste Less Assistant")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Welcome, $name!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // navigate to add item screen (to be created)
              },
              child: Text("Add Item"),
            ),
            ElevatedButton(
              onPressed: () {
                // navigate to items list screen (to be created)
              },
              child: Text("View Items"),
            ),
            ElevatedButton(
              onPressed: () {
                // logout = navigate back to login
                Navigator.pop(context);
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
