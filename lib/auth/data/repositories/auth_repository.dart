import 'package:city_guide/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  late Dio http;
  AuthRepository({
    required this.http,
  });

  Future<UserModel?> loging(
      {required String email, required String password}) async {
    Map<String, dynamic> data = {};

    data['email'] = email;
    data['password'] = password;

    //? get token
    Response response = await http.post(
      '/auth/login',
      queryParameters: data,
    );

    //??? serve token
    final prefs = await SharedPreferences.getInstance();
    String accessToken = response.data['access_token'];
    await prefs.setString('access_token', accessToken);

    //?? get user
    return await getUser();
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('access_token');
    print(accessToken);

    if (accessToken != null) {
      Map<String, dynamic> headers = {};
      headers['Authorization'] = "Bearer $accessToken";

      Response response = await http.get(
        '/auth/user',
        options: Options(
          headers: headers,
        ),
      );

      print(response.data);

      return UserModel.fromJson(response.data);
    }
    return null;
  }

  register({
    required String name,
    required String email,
    required String password,
  }) async {
    Response response = await http.post("/api/users", queryParameters: {
      'email': email,
      'name': name,
      'password': password,
    });
    print(response);

    return UserModel.fromJson(response.data);
  }
}
