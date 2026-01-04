import 'package:flutter/material.dart';
import '../classes/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onDeleted;

  const ItemCard({Key? key, required this.item, required this.onDeleted})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade100,
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          "Category: ${item.category}\nExpiry: ${item.expiryDate}",
        ),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              tooltip: "Delete",
              onPressed: onDeleted,
            ),
          ],
        ),
      ),
    );
  }
}
