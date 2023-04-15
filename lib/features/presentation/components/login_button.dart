import 'package:cubit_mvvm_clean/core/constants/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final double horizontalPadding;
  const LoginButton({super.key, required this.iconPath, required this.label,required this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: SvgPicture.asset(
        iconPath,
        width: 25,
        height: 25,
        color: Colors.white,
      ),
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: horizontalPadding),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Palette.fourth),
              borderRadius: BorderRadius.circular(12))),
    );
  }
}
