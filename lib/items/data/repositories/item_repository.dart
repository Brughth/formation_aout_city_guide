import 'package:city_guide/items/data/models/item_model.dart';
import 'package:dio/dio.dart';

class ItemRepository {
  late Dio http;
  ItemRepository({required this.http});

  Future<List<ItemModel>> find({
    String? seachTerm,
  }) async {
    List<ItemModel> results = [];
    Map<String, dynamic> params = {};
    if (seachTerm != null) {
      params["s"] = seachTerm;
    }

    Response response = await http.get(
      "/api/items",
      queryParameters: params,
    );
    for (var i = 0; i < response.data['data'].length; i++) {
      var jsonItem = response.data['data'][i];
      results.add(ItemModel.fromJson(jsonItem));
    }

    return results;
  }
}
