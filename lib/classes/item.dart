import 'dart:convert';
import 'package:http/http.dart' as http;

class Item {
  final int id;
  final String name;
  final String category;
  final String expiryDate;

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.expiryDate,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      expiryDate: json['expiry_date'],
    );
  }

  // Static method to fetch items for a user
  static Future<List<Item>> fetchItems(int userId) async {
    const String apiUrl =
        "http://mhmdshami.atwebpages.com/backend/api/get_items.php";

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"user_id": userId}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final items = data['items'] as List;
      return items.map((json) => Item.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch items");
    }
  }
}
