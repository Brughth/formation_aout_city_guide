import 'package:city_guide/items/presentation/widgets/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../business_logic/items_provider.dart';

class ItemsListPage extends StatefulWidget {
  const ItemsListPage({Key? key}) : super(key: key);

  @override
  State<ItemsListPage> createState() => _ItemsListPageState();
}

class _ItemsListPageState extends State<ItemsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<ItemsProvider>(
              builder: (context, itemsProvider, child) {
                if (itemsProvider.items == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                var items = itemsProvider.items!;
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    var item = items[index];
                    return ItemTile(item: item);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
