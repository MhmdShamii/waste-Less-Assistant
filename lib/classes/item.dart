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
}
