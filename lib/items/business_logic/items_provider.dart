import 'package:city_guide/items/data/models/item_model.dart';
import 'package:city_guide/items/data/repositories/item_repository.dart';
import 'package:flutter/material.dart';

class ItemsProvider extends ChangeNotifier {
  late ItemRepository itemRepository;
  ItemsProvider({
    required this.itemRepository,
  });
  List<ItemModel>? _items;

  List<ItemModel>? get items => _items;

  loadItems() async {
    _items = await itemRepository.find();
    notifyListeners();
  }
}
