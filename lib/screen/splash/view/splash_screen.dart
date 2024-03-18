import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/fire_helper/fireauth_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    bool isLogin = FireAuthHelper.fireAuthHelper.checkUser();
    Timer(
      const Duration(seconds: 3),
          () => Get.offAllNamed(isLogin==false?'signin':'dash'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,

          color: const Color(0xff6C63FF),
          child: Center(
            child: Image.asset(
              "assets/image/explora.png",
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
