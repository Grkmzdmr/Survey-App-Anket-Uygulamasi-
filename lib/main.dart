import 'package:cubit_mvvm_clean/core/constants/palette.dart';
import 'package:cubit_mvvm_clean/core/services/services_locator.dart';
import 'package:cubit_mvvm_clean/features/presentation/login_cubit/login_cubit.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/home_page.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/login_page.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/nlogin_page.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/review_page.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  var tokenBox = await Hive.openBox('tokenBox');
  await Hive.openBox("regionBox");
  await Hive.openBox("smallRegionBox");

  setUpServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: (context) {
    //       return LoginCubit();
    //     })
    //   ],
    //   child:
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          routes: {
            '/review': (context) => ReviewPage(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Login With Cubit',
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: Palette.primary),
          home: SplashScreen());
    });
  }
}
