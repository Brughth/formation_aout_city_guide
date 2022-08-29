import 'package:city_guide/items/business_logic/search_provider.dart';
import 'package:city_guide/items/presentation/widgets/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, searchProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Search Page"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _textEditingController,
                        onFieldSubmitted: (value) {
                          searchProvider.search(
                              searchTerm: _textEditingController.text);
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        searchProvider.search(
                            searchTerm: _textEditingController.text);
                      },
                      icon: Icon(
                        Icons.search,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                if (searchProvider.searchResults == null)
                  const Text(
                    "Type your search Term",
                    textAlign: TextAlign.center,
                  ),
                if (searchProvider.isSearching == true)
                  const Center(child: CircularProgressIndicator()),
                const Divider(),
                if (searchProvider.searchResults != null)
                  Expanded(
                    child: ListView.builder(
                      itemCount: searchProvider.searchResults!.length,
                      itemBuilder: (context, index) {
                        return ItemTile(
                          item: searchProvider.searchResults![index],
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
