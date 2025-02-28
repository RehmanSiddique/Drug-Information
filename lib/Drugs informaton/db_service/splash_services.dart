import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../ui/auth/wLogin_screen.dart';
import '../ui/home/drug_home.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null) {
      Timer(
          const Duration(seconds: 5),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => DrugHomePage())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => WLoginPage())));
    }
  }
}
