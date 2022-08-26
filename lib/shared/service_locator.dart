import 'package:city_guide/items/business_logic/items_provider.dart';
import 'package:city_guide/items/data/repositories/item_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupLocator() {
  getIt.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: "https://api.immo-invr.com")),
  );
  getIt.registerSingleton<ItemRepository>(
    ItemRepository(http: getIt.get<Dio>()),
  );
  getIt.registerSingleton<ItemsProvider>(
      ItemsProvider(itemRepository: getIt.get<ItemRepository>()));
}
