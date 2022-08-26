import 'package:city_guide/items/data/models/item_model.dart';
import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final ItemModel item;
  const ItemTile({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      subtitle: Row(
        children: [
          const Icon(Icons.location_city),
          Expanded(child: Text(item.city.name)),
        ],
      ),
    );
  }
}
