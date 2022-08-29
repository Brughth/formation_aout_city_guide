import 'package:city_guide/items/business_logic/favorites_provider.dart';
import 'package:city_guide/items/data/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          Consumer<FavoritesProvider>(
            builder: (context, favoritesProvider, child) {
              return favoritesProvider.isInFavoritesList(item)
                  ? GestureDetector(
                      onTap: () {
                        favoritesProvider.removeFromFavorites(item);
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        favoritesProvider.addToFavorites(item);
                      },
                      child: const Icon(
                        Icons.favorite_border,
                      ),
                    );
            },
          )
        ],
      ),
    );
  }
}
