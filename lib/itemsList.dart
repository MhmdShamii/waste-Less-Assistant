import 'package:flutter/material.dart';
import 'package:project_phase_2_wast_less_assistant/usedItemsList.dart';
import 'package:project_phase_2_wast_less_assistant/widgets/custom_button.dart';
import '../classes/item.dart';
import '../widgets/itemCard.dart';

class ItemsListPage extends StatefulWidget {
  final int userId;

  const ItemsListPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<ItemsListPage> createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {
  late Future<List<Item>> itemsFuture;
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    itemsFuture = Item.fetchItems(widget.userId);
    items = await itemsFuture;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Items"), backgroundColor: Colors.orange),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // overall padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomButton(
              text: "View Used Items",
              color: Colors.blue,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UsedItemsListPage(userId: widget.userId),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: items.isEmpty
                  ? Center(child: Text("No items found"))
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: ItemCard(
                            item: items[index],
                            onDeleted: () async {
                              await Item.deleteItem(items[index].id);
                              setState(() {
                                items.removeAt(index);
                              });
                            },
                            onMarkedUsed: () async {
                              await Item.markUsedItem(items[index].id);
                              setState(() {
                                items[index].used = true;
                              });
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
