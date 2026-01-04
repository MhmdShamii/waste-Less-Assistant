import 'package:flutter/material.dart';
import 'widgets/custom_button.dart';
import 'classes/user.dart';
import 'classes/category.dart';
import 'classes/item.dart';

class AddItemPage extends StatefulWidget {
  final User user;
  AddItemPage({required this.user});

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  bool loading = false;

  List<Category> categories = [];
  Category? selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  // Load categories from backend
  void _loadCategories() async {
    try {
      categories = await Category.fetchCategories();
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to load categories")));
    }
  }

  // Pick expiry date
  Future<void> pickDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 5)),
    );

    if (selectedDate != null) {
      setState(() {
        expiryController.text = selectedDate.toIso8601String().split('T')[0];
      });
    }
  }

  // Submit item using Item.addItem method
  void submitItem() async {
    if (nameController.text.isEmpty ||
        selectedCategory == null ||
        expiryController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Please fill all fields")));
      return;
    }

    setState(() => loading = true);

    try {
      await Item.addItem(
        userId: widget.user.id,
        name: nameController.text.trim(),
        categoryId: selectedCategory!.id,
        expiryDate: expiryController.text.trim(),
      );

      setState(() {
        loading = false;
        nameController.clear();
        expiryController.clear();
        selectedCategory = null;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Item added successfully")));
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
            // Item Name
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Item Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Category dropdown
            categories.isEmpty
                ? CircularProgressIndicator()
                : DropdownButtonFormField<Category>(
                    value: selectedCategory,
                    hint: Text("Select Category"),
                    items: categories.map((cat) {
                      return DropdownMenuItem<Category>(
                        value: cat,
                        child: Text(cat.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
            SizedBox(height: 16),

            // Expiry Date
            TextField(
              controller: expiryController,
              readOnly: true,
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

            // Submit button
            loading
                ? CircularProgressIndicator()
                : CustomButton(
                    text: "Add Item",
                    color: Colors.green,
                    onTap: submitItem,
                  ),
          ],
        ),
      ),
    );
  }
}
