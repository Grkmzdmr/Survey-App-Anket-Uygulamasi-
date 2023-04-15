import 'package:flutter/cupertino.dart';

class MainPageClass {
  IconData? icon;
  String? title;

  MainPageClass(this.icon, this.title);
}

class ReviewsToReviews {
  int id;
  Map<int, TextEditingController> textControllers;
  List<int> groupValues;
  ReviewsToReviews(this.id,this.textControllers,this.groupValues);
}
