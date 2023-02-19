import 'package:cubit_mvvm_clean/core/services/services_locator.dart';
import 'package:cubit_mvvm_clean/features/presentation/login_cubit/login_cubit.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login With Cubit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage());
  }
}
