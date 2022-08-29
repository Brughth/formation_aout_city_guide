import 'package:city_guide/items/business_logic/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/item_tile.dart';

class FavoriteItemsPage extends StatefulWidget {
  const FavoriteItemsPage({Key? key}) : super(key: key);

  @override
  State<FavoriteItemsPage> createState() => _FavoriteItemsPageState();
}

class _FavoriteItemsPageState extends State<FavoriteItemsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Items"),
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          if (favoritesProvider.favoritesList.isEmpty) {
            return const Center(child: Text("No Favorite Items"));
          }

          var items = favoritesProvider.favoritesList;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              var item = items[index];
              return ItemTile(item: item);
            },
          );
        },
      ),
    );
  }
}
