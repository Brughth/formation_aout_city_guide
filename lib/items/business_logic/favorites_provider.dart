import 'package:city_guide/items/data/models/item_model.dart';
import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  List<ItemModel> favoritesList = [];

  isInFavoritesList(ItemModel item) {
    return favoritesList.indexWhere((element) => element.id == item.id) >= 0;
  }

  addToFavorites(ItemModel item) {
    favoritesList.add(item);
    notifyListeners();
  }

  removeFromFavorites(item) {
    favoritesList.removeWhere((element) => element.id == item.id);
    notifyListeners();
  }
}
