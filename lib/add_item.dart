import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'widgets/custom_button.dart';
import 'classes/user.dart';

class AddItemPage extends StatefulWidget {
  final User user;
  AddItemPage({required this.user});

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  TextEditingController name = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  bool loading = false;

  // New: Show date picker
  Future<void> pickDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
    );

    if (selectedDate != null) {
      setState(() {
        expiryDate.text = selectedDate.toIso8601String().split('T')[0];
      });
    }
  }

  void addItem() async {
    if (name.text.isEmpty || category.text.isEmpty || expiryDate.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() => loading = true);

    try {
      var url = Uri.parse(
        "http://mhmdshami.atwebpages.com/backend/api/add_item.php",
      );

      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": widget.user.id,
          "name": name.text.trim(),
          "category": category.text.trim(),
          "expiry_date": expiryDate.text.trim(),
        }),
      );

      setState(() => loading = false);

      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['message'] != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(data['message'])));
        name.clear();
        category.clear();
        expiryDate.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['error'] ?? "Failed to add item")),
        );
      }
    } catch (e) {
      setState(() => loading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Add Item"),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(
                labelText: "Item Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: category,
              decoration: InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Expiry date field with calendar
            TextField(
              controller: expiryDate,
              readOnly: true, // user cannot type manually
              decoration: InputDecoration(
                labelText: "Expiry Date",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: pickDate,
            ),
            SizedBox(height: 24),
            loading
                ? CircularProgressIndicator()
                : CustomButton(
                    text: "Add Item",
                    color: Colors.green,
                    onTap: addItem,
                  ),
          ],
        ),
      ),
    );
  }
}
