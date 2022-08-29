import 'package:city_guide/items/business_logic/search_provider.dart';
import 'package:city_guide/items/data/repositories/item_repository.dart';
import 'package:city_guide/items/presentation/search_page.dart';
import 'package:city_guide/items/presentation/widgets/item_tile.dart';
import 'package:city_guide/shared/service_locator.dart';
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
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) =>
                        SearchProvider(getIt.get<ItemRepository>()),
                    child: const SearchPage(),
                  ),
                ),
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
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
      ),
    );
  }
}

class Box extends StatelessWidget {
  const Box({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3,
        ),
        color: Colors.red,
      ),
    );
  }
}
