import 'package:city_guide/items/business_logic/favorites_provider.dart';
import 'package:city_guide/items/presentation/favorite_items_page.dart';
import 'package:city_guide/items/presentation/items_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: activeIndex,
        children: const [
          ItemsListPage(),
          FavoriteItemsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIndex,
        onTap: (index) {
          setState(() {
            activeIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home"),
          BottomNavigationBarItem(
            icon: Consumer<FavoritesProvider>(
              builder: (context, favoritesProvider, child) {
                return Stack(
                  alignment: Alignment.center,
                  fit: StackFit.passthrough,
                  children: [
                    Icon(Icons.favorite),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "${favoritesProvider.favoritesList.length}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
