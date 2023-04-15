import 'package:cubit_mvvm_clean/features/presentation/components/login_button.dart';
import 'package:flutter/material.dart';


class NLoginPage extends StatefulWidget {
  const NLoginPage({super.key});

  @override
  State<NLoginPage> createState() => _NLoginPageState();
}

class _NLoginPageState extends State<NLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset("assets/images/signin_balls.png"),
              const Text(
                "Giriş yap.",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
              ),
              const SizedBox(height: 50),
              const LoginButton(
                iconPath: "assets/images/g_logo.svg",
                label: "Google ile giriş yap.",
                horizontalPadding: 30,
              ),
              SizedBox(
                height: 15,
              ),
              Text("Ya da")
            ],
          ),
        ),
      ),
    );
  }
}
