import 'package:flutter/material.dart';
import 'widgets/custom_button.dart';
import 'add_item.dart';
import 'itemsList.dart';
import 'classes/user.dart';

class HomePage extends StatelessWidget {
  final User user;

  HomePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Waste Less Assistant"),
        backgroundColor: Colors.green[700],
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
              user.name,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddItemPage(user: user)),
                );
              },
            ),
            SizedBox(height: 20),
            CustomButton(
              text: "View Items",
              color: Colors.orange,
              icon: Icons.list_alt,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ItemsListPage(userId: user.id),
                  ),
                );
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
