import 'package:flutter/material.dart';
import '../classes/item.dart';
import '../widgets/usedItemCard.dart';

class UsedItemsListPage extends StatefulWidget {
  final int userId;

  const UsedItemsListPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UsedItemsListPage> createState() => _UsedItemsListPageState();
}

class _UsedItemsListPageState extends State<UsedItemsListPage> {
  late Future<List<Item>> itemsFuture;
  List<Item> items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    itemsFuture = Item.getUsedItems(widget.userId);
    items = await itemsFuture;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Used Recently"),
        backgroundColor: Colors.orange,
      ),
      body: items.isEmpty
          ? Center(child: Text("No items found"))
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ItemCard(
                  item: items[index],
                  onDeleted: () async {
                    await Item.deleteItem(items[index].id);
                    setState(() {
                      items.removeAt(index);
                    });
                  },
                );
              },
            ),
    );
  }
}
