import 'package:cubit_mvvm_clean/core/constants/regions.dart';

class RegionsModel {
  int id;
  String regions;

  RegionsModel(this.id,this.regions);
}

class SmallRegionsModel {
  String smallRegions;
  int topRegionsId;

  SmallRegionsModel(this.smallRegions, this.topRegionsId);
}
