import 'dart:async';

import 'package:cubit_mvvm_clean/core/constants/palette.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/home_page.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
  final tokenBox = Hive.box("tokenBox");

  _startDelay() {
    _timer = Timer(const Duration(seconds: 2, milliseconds: 8), _goNext);
  }

  _goNext() async {
    var token = tokenBox.get("token");

    if (token.toString().length > 10) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: Center(
          child: CircularProgressIndicator(
            color: Palette.primary,
            strokeWidth: 3,
          ),
        ));
  }
}
