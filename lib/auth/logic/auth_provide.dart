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

  bool _isLogingIn = false;
  bool get isLogingIn => _isLogingIn;

  setLoginIn(bool value) {
    _isLogingIn = value;
    notifyListeners();
  }

  bool _successLogin = false;
  bool get successLoginIn => _successLogin;

  login({
    required String email,
    required String password,
  }) async {
    _isLogingIn = true;
    _successLogin = false;
    notifyListeners();

    _user = await authRepository.loging(email: email, password: password);

    print(_user);

    _successLogin = true;
    _isLogingIn = false; //loic.ngou98@gmail.com
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  register({
    required String name,
    required String email,
    required String password,
  }) async {
    setLoading(true);

    _user = await authRepository.register(
      name: name,
      email: email,
      password: password,
    );

    setLoading(false);
  }
}
