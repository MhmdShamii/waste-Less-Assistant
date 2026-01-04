import 'package:flutter/material.dart';
import '../classes/item.dart';

class ItemCard extends StatelessWidget {
  final Item item;
  final VoidCallback onDeleted;
  final VoidCallback onMarkedUsed;

  const ItemCard({
    Key? key,
    required this.item,
    required this.onDeleted,
    required this.onMarkedUsed,
  }) : super(key: key);

  Color _getCardColor() {
    final expiry = DateTime.parse(item.expiryDate);
    final now = DateTime.now();
    final diff = expiry.difference(now).inDays;

    if (item.used) return Colors.grey.shade300; // used
    if (diff <= 0) return Colors.red.shade300; // expired
    if (diff <= 2) return Colors.orange.shade300; // very soon
    if (diff <= 5) return Colors.yellow.shade200; // soon
    return Colors.green.shade100; // safe
  }

  bool _isExpired() {
    final expiry = DateTime.parse(item.expiryDate);
    return expiry.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getCardColor(),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        title: Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          "Category: ${item.category}\nExpiry: ${item.expiryDate}",
        ),
        trailing: Wrap(
          spacing: 8,
          children: [
            // Show "Mark as used" only if not used and not expired
            if (!item.used && !_isExpired())
              IconButton(
                icon: Icon(Icons.check, color: Colors.blue),
                tooltip: "Mark as used",
                onPressed: onMarkedUsed,
              ),
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
