import 'dart:convert';
import 'package:http/http.dart' as http;

class Item {
  final int id;
  final String name;
  final String category;
  final String expiryDate;
  bool used; // mutable so we can mark as used

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.expiryDate,
    this.used = false,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      expiryDate: json['expiry_date'],
      used: json['used'] == 1,
    );
  }

  static Future<String> addItem({
    required int userId,
    required String name,
    required int categoryId,
    required String expiryDate,
  }) async {
    final url = Uri.parse(
      "http://mhmdshami.atwebpages.com/backend/api/add_item.php",
    );

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "name": name,
        "category_id": categoryId,
        "expiry_date": expiryDate,
      }),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200 && data['message'] != null) {
      return data['message']; // success
    } else {
      throw Exception(data['error'] ?? "Failed to add item");
    }
  }

  // Fetch items for a user
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

  static Future<List<Item>> getUsedItems(int userId) async {
    const String apiUrl =
        "http://mhmdshami.atwebpages.com/backend/api/get_used_items.php";
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

  // Delete item
  static Future<void> deleteItem(int itemId) async {
    const String apiUrl =
        "http://mhmdshami.atwebpages.com/backend/api/delete_item.php";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"item_id": itemId}),
    );
    if (response.statusCode != 200) throw Exception("Failed to delete item");
  }

  // Mark as used
  static Future<void> markUsedItem(int itemId) async {
    const String apiUrl =
        "http://mhmdshami.atwebpages.com/backend/api/mark_used_item.php";
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"item_id": itemId}),
    );
    if (response.statusCode != 200) throw Exception("Failed to mark as used");
  }
}
