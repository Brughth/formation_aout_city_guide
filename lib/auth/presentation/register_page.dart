import 'package:city_guide/auth/logic/auth_provide.dart';
import 'package:city_guide/shared/screens/homepage.dart';
import 'package:city_guide/shared/utils/alert.dart';
import 'package:city_guide/shared/utils/app_colors.dart';
import 'package:city_guide/shared/utils/validators.dart';
import 'package:city_guide/shared/widgets/app_button.dart';
import 'package:city_guide/shared/widgets/app_input.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResgisterPage extends StatefulWidget {
  const ResgisterPage({super.key});

  @override
  State<ResgisterPage> createState() => _ResgisterPageState();
}

class _ResgisterPageState extends State<ResgisterPage> {
  var _formKey = GlobalKey<FormState>();
  bool visibily = true;

  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    AuthProvider authProvider = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Form(
          key: _formKey,
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
                controller: _nameController,
                label: "Name",
                hintText: "Enter your name",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  return Validators.required("Email", value);
                },
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
                      loading: context.watch<AuthProvider>().isLoading,
                      loadingColor: AppColors.primaryGrayText,
                      text: const Text(
                        "Create Account",
                        style: TextStyle(
                          color: AppColors.primaryGrayText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await authProvider.register(
                              name: _nameController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );
                            if (mounted) {
                              showSuccessMessage("Success", context);
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                                (route) => false,
                              );
                            }
                          } on DioError catch (e) {
                            print(e);
                            authProvider.setLoading(false);
                            showWarningMessage(
                                "${e.response?.data['error'] ?? "une erreur inconue s'est produite"}",
                                context);
                          } catch (e) {
                            print(e);
                            authProvider.setLoading(false);
                            showErrorMessage("!!Error loginIn ", context);
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
