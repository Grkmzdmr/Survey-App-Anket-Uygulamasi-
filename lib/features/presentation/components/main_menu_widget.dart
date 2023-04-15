import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../../core/constants/palette.dart';

class MainMenuWidget extends StatelessWidget {
  IconData? icon;
  String? title;
  MainMenuWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Icon(
              icon,
              size: 8.h,
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(title ?? ""),
            SizedBox(
              height: 2.h,
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Palette.primary,
          borderRadius: BorderRadius.circular(30),
        ),
        height: 2.h,
      ),
    );
  }
}
