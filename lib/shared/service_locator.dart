import 'package:city_guide/auth/data/repositories/auth_repository.dart';
import 'package:city_guide/auth/logic/auth_provide.dart';
import 'package:city_guide/items/business_logic/items_provider.dart';
import 'package:city_guide/items/data/repositories/item_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupLocator() {
  // Dio
  getIt.registerSingleton<Dio>(
    Dio(BaseOptions(baseUrl: "https://city-api.ntech-services.com")),
  );

  // Items
  getIt.registerSingleton<ItemRepository>(
    ItemRepository(http: getIt.get<Dio>()),
  );
  getIt.registerSingleton<ItemsProvider>(
    ItemsProvider(
      itemRepository: getIt.get<ItemRepository>(),
    ),
  );

  // auth
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      http: getIt.get<Dio>(),
    ),
  );
  getIt.registerLazySingleton<AuthProvider>(
    () => AuthProvider(authRepository: getIt.get<AuthRepository>()),
  );
}
