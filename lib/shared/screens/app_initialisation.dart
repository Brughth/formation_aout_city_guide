import 'package:city_guide/auth/logic/auth_provide.dart';
import 'package:city_guide/shared/screens/homepage.dart';
import 'package:city_guide/shared/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppInitialisation extends StatefulWidget {
  AppInitialisation({super.key});

  @override
  State<AppInitialisation> createState() => _AppInitialisationState();
}

class _AppInitialisationState extends State<AppInitialisation> {
  AuthProvider authProvider = getIt.get<AuthProvider>();

  @override
  void initState() {
    authProvider.checkAuthState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<AuthProvider>().isAuthtenticated) {
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
          (route) => false,
        );
      }
    }

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
      ],
    ));
  }
}
