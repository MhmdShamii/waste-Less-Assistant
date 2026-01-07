import 'dart:convert';
import 'package:http/http.dart' as http;

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: int.parse(json['id'].toString()),
      name: json['name'].toString(),
    );
  }

  static Future<List<Category>> fetchCategories() async {
    const String apiUrl =
        "http://mhmdshami.atwebpages.com/backend/api/get_categories.php";
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List categories = data['categories'];
      return categories.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch categories");
    }
  }
}
