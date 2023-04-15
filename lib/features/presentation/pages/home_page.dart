import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:cubit_mvvm_clean/core/constants/palette.dart';
import 'package:cubit_mvvm_clean/core/constants/regions.dart';
import 'package:cubit_mvvm_clean/features/data/models/regions.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/main_page.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/selected_item.dart';
import 'package:cubit_mvvm_clean/features/presentation/components/main_menu_widget.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/login_page.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/review_page.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/reviews_page.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MainPageClass> gridViewSource = [
    MainPageClass(Icons.reviews, "Anket Başlat"),
    MainPageClass(Icons.location_city, "Bölge Seç"),
    MainPageClass(Icons.logout, "Çıkış Yap")
  ];
  final regionBox = Hive.box("regionBox");
  final smallRegionBox = Hive.box("smallRegionBox");
  final tokenBox = Hive.box("tokenBox");
  String? regionString = "";
  String? smallRegionString = "";
  List<SmallRegionsModel> smallRegionList = SmallRegions.smallRegionsList;

  @override
  void initState() {
    regionString = regionBox.get("regionBox");
    smallRegionString = smallRegionBox.get("smallRegionBox");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade800,
        floatingActionButton: SizedBox(
          height: 12.h,
          width: 20.w,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReviewsPage()));
            },
            backgroundColor: Palette.primary,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Aktif Bölge",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(regionBox.get("regionBox") ?? ""),
                SizedBox(
                  height: 1.h,
                ),
                Text(smallRegionBox.get("smallRegionBox") ?? ""),
                SizedBox(
                  height: 4.h,
                ),
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (gridViewSource[index].title! == "Anket Başlat") {
                            if (regionBox.get("regionBox") == null ||
                                smallRegionBox.get("smallRegionBox") == null) {
                              showFlushbar(
                                  context: context,
                                  flushbar: Flushbar(
                                    title: "Hatalı Giriş",
                                    icon: const Icon(
                                      Icons.dangerous,
                                      color: Colors.red,
                                    ),
                                    duration: const Duration(seconds: 3),
                                    message:
                                        "Anket başlatmadan önce bölge seçiniz !",
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: Colors.white,
                                    titleColor: Colors.red,
                                    messageColor: Colors.red,
                                    borderRadius: BorderRadius.circular(12),
                                    margin: const EdgeInsets.all(16),
                                  )..show(context));
                              return;
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ReviewsPage()));
                          }
                          if (gridViewSource[index].title! == "Çıkış Yap") {
                            tokenBox.delete("token");
                            regionBox.delete("regionBox");
                            smallRegionBox.delete("smallRegionBox");
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          }
                          if (gridViewSource[index].title! == "Bölge Seç") {
                            Widget cancelButton = TextButton(
                              child: const Text(
                                "İptal",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                            Widget continueButton = TextButton(
                              child: const Text(
                                "Kaydet",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                if (regionString != null &&
                                    smallRegionString != null &&
                                    regionString != "" &&
                                    smallRegionString != "") {
                                  regionBox.put("regionBox", regionString);
                                  smallRegionBox.put(
                                      "smallRegionBox", smallRegionString);
                                  Navigator.pop(context);
                                  setState(() {});
                                  return;
                                }

                                Flushbar(
                                    message:
                                        "Lütfen ilçe ve mahalleyi seçiniz !");
                              },
                            );

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return regionAlert(
                                    cancelButton, continueButton);
                              },
                            );
                          }
                        },
                        child: MainMenuWidget(
                          icon: gridViewSource[index].icon,
                          title: gridViewSource[index].title,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  AlertDialog regionAlert(Widget cancelButton, Widget continueButton) {
    return AlertDialog(
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 5.h,
              ),
              const Text("İlçe Seçiniz"),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                child: DropdownButton(
                    style: const TextStyle(height: 1.2),
                    value: regionString,
                    isExpanded: true,
                    isDense: true,
                    onChanged: (newValue) {
                      setState(() {
                        regionString = newValue;

                        RegionsModel region = Regions.regionList.firstWhere(
                            (element) => element.regions == newValue);

                        smallRegionList = SmallRegions.smallRegionsList
                            .where(
                                (element) => element.topRegionsId == region.id)
                            .toList();

                        if (smallRegionList.isNotEmpty) {
                          smallRegionString =
                              smallRegionList.first.smallRegions;
                        }
                      });
                    },
                    items: Regions.regionList.map((item) {
                      return DropdownMenuItem(
                        value: item.regions,
                        child: Text(item.regions),
                      );
                    }).toList()),
              ),
              SizedBox(
                height: 6.h,
              ),
              const Text("Mahalle Seçiniz"),
              SizedBox(
                height: 1.h,
              ),
              smallRegionString == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                      child: DropdownButton(
                          style: const TextStyle(height: 1),
                          isExpanded: true,
                          value: smallRegionString,
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() => smallRegionString = newValue);
                          },
                          items: smallRegionList.map((item) {
                            return DropdownMenuItem(
                              value: item.smallRegions,
                              child: Text(item.smallRegions),
                            );
                          }).toList())),
            ],
          );
        },
      ),
      title: Text("Bölge Seç"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  }
}
