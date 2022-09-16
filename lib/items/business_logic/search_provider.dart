import 'package:city_guide/items/data/models/item_model.dart';
import 'package:city_guide/items/data/repositories/item_repository.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  final ItemRepository itemRepository;
  SearchProvider(this.itemRepository);

  String? searchTerm;
  List<ItemModel>? searchResults;
  bool isSearching = false;
  search({String? searchTerm}) async {
    isSearching = true;
    this.searchTerm = searchTerm;
    notifyListeners();
    searchResults = await itemRepository.find(seachTerm: searchTerm);
    isSearching = false;
    notifyListeners();
  }
}
