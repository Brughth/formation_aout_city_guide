import 'dart:developer';

import 'package:city_guide/auth/data/repositories/auth_repository.dart';
import 'package:city_guide/auth/logic/auth_provide.dart';
import 'package:city_guide/auth/presentation/register_page.dart';
import 'package:city_guide/shared/screens/homepage.dart';
import 'package:city_guide/shared/utils/alert.dart';
import 'package:city_guide/shared/utils/app_colors.dart';
import 'package:city_guide/shared/utils/validators.dart';
import 'package:city_guide/shared/widgets/app_button.dart';
import 'package:city_guide/shared/widgets/app_input.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _formKey = GlobalKey<FormState>();
  bool visibily = true;

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    AuthProvider authProvider = context.read<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: ListView(
              children: [
                SizedBox(
                  height: screenHeight * .06,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    text: "Discover ",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      letterSpacing: .2,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Popular \nPlaces ",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .2,
                        ),
                      ),
                      TextSpan(
                        text: "In ",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          height: 1,
                          letterSpacing: .2,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "Cameroon",
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          letterSpacing: .2,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * .05,
                ),
                AppInput(
                  controller: _emailController,
                  label: "Email",
                  hintText: "Enter email address",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    return Validators.required("Email", value);
                  },
                ),
                AppInput(
                  controller: _passwordController,
                  label: "Password",
                  hintText: "Choose a password",
                  maxLine: 1,
                  minLine: 1,
                  suffix: InkWell(
                    onTap: () {
                      setState(() {
                        visibily = !visibily;
                      });
                    },
                    child: Icon(
                      visibily ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  obscureText: visibily,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    return Validators.required("password", value);
                  },
                ),
                const SizedBox(
                  height: 45,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppButton(
                        loading: context.watch<AuthProvider>().isLogingIn,
                        loadingColor: AppColors.primaryGrayText,
                        text: const Text(
                          "Login",
                          style: TextStyle(
                            color: AppColors.primaryGrayText,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await authProvider.login(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                              _emailController.clear();
                              _passwordController.clear();
                              if (mounted) {
                                showSuccessMessage("Success Login", context);
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()),
                                  (route) => false,
                                );
                              }
                            } on DioError catch (e) {
                              print(e);
                              authProvider.setLoginIn(false);
                              showWarningMessage(
                                  "${e.response?.data['error'] ?? "une erreur inconue s'est produite"}",
                                  context);
                            } catch (e) {
                              print(e);
                              authProvider.setLoginIn(false);
                              showErrorMessage("!!Error loginIn ", context);
                            }
                          }
                        },
                      ),
                      AppButton(
                        loadingColor: AppColors.primary,
                        text: const Text(
                          "Create Account",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        color: AppColors.black,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ResgisterPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
