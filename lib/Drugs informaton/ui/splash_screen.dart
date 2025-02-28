import 'package:flutter/material.dart';

import '../db_service/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();

  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Image(
          fit: BoxFit.contain,
          // width: double.infinity,
          height: 1000,
          image: AssetImage("assets/images/splash.png")),
    );
  }
}
