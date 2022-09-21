import 'package:city_guide/auth/logic/auth_provide.dart';
import 'package:city_guide/auth/presentation/login_page.dart';
import 'package:city_guide/items/business_logic/favorites_provider.dart';
import 'package:city_guide/items/business_logic/items_provider.dart';
import 'package:city_guide/shared/screens/app_initialisation.dart';
import 'package:city_guide/shared/screens/homepage.dart';
import 'package:city_guide/shared/service_locator.dart';
import 'package:city_guide/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => getIt.get<AuthProvider>(),
        ),
        ChangeNotifierProvider<ItemsProvider>(
          create: (context) => getIt.get<ItemsProvider>()..loadItems(),
        ),
        ChangeNotifierProvider<FavoritesProvider>(
          create: (context) => FavoritesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: AppColors.createMaterialColor(AppColors.primary),
        ),
        home: AppInitialisation(),
      ),
    );
  }
}
