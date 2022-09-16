import 'package:city_guide/auth/data/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';

import 'package:city_guide/auth/data/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  late AuthRepository authRepository;
  AuthProvider({
    required this.authRepository,
  });

  UserModel? _user;
  UserModel? get user => _user;

  bool isLogingIn = false;
  bool successLoginIn = false;

  login({required String email, required String password}) async {
    isLogingIn = true;
    notifyListeners();

    _user = await authRepository.loging(email: email, password: password);

    print(_user);
    successLoginIn = true;
    isLogingIn = false; //loic.ngou98@gmail.com
    notifyListeners();
  }
}
