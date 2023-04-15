import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:cubit_mvvm_clean/core/constants/palette.dart';
import 'package:cubit_mvvm_clean/features/presentation/login_cubit/login_cubit.dart';
import 'package:cubit_mvvm_clean/features/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final tokenBox = Hive.box("tokenBox");
  bool visible = true;

  @override
  void initState() {
    super.initState();
    //context.read<LoginCubit>().login(sign, password, deviceId, userDeviceTypeId)
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) =>
          LoginCubit(_usernameController, _passwordController, formKey),
      child: Scaffold(
          backgroundColor: Palette.primary,
          body: SafeArea(
              child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.1,
                  ),
                  titleWidget(context),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  subtitleWidget(context),
                  SizedBox(
                    height: height * 0.2,
                  ),
                  usernameField(),
                  passwordField(),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  loginButton(height, context),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 6.0),
                  //   child: TextButton(
                  //       onPressed: () {},
                  //       child: Text(
                  //         "Üye Değil Misin ? Hemen Üye Ol",
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .bodyMedium!
                  //             .copyWith(color: Colors.white),
                  //       )),
                  // )
                ],
              ),
            ),
          ))),
    );
  }

  Padding usernameField() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.black),
        controller: _usernameController,
        cursorColor: Palette.primary,
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.person,
              color: Palette.primary,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: const BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: const BorderSide(color: Colors.white))),
      ),
    );
  }

  Padding passwordField() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.black),
        obscureText: visible,
        controller: _passwordController,
        cursorColor: Palette.primary,
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.password,
              color: Palette.primary,
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.visibility),
              onPressed: () {
                setState(() {
                  visible = !visible;
                });
              },
              color: Palette.primary,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: const BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: const BorderSide(color: Colors.white))),
      ),
    );
  }

  Padding titleWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Text(
            "Hoşgeldin.",
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Padding subtitleWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "",
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget loginButton(double height, BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFinished) {
          if (state.loginResponseData.success == true) {
            tokenBox.put("token", state.loginResponseData.data!);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            showFlushbar(
                context: context,
                flushbar: Flushbar(
                  title: "Hatalı Giriş",
                  icon: const Icon(
                    Icons.dangerous,
                    color: Colors.red,
                  ),
                  duration: const Duration(seconds: 3),
                  message: "Kullanıcı adınızı ve şifrenizi kontrol ediniz !",
                  flushbarPosition: FlushbarPosition.TOP,
                  backgroundColor: Colors.white,
                  titleColor: Colors.red,
                  messageColor: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                  margin: const EdgeInsets.all(16),
                )..show(context));
          }
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return SizedBox(
              height: height * 0.07,
              width: height * 0.2,
              child: const Center(
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 6),
              ));
        } else {
          return SizedBox(
            height: height * 0.07,
            width: height * 0.2,
            child: ElevatedButton(
              onPressed: () {
                context
                    .read<LoginCubit>()
                    .login(_usernameController.text, _passwordController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.fourth,

                //onPrimary: Colors.black,
              ),
              child: const Text("Giriş Yap"),
            ),
          );
        }
      },
    );
  }
}



/*

 BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoginInitial) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Text(
                            "Hoşgeldin.",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Giriş yap ve eğlenceye katıl.",
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .headline5!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.2,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: _usernameController,
                        cursorColor: Palette.primary,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Palette.primary,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(36),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(36),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: _passwordController,
                        cursorColor: Palette.primary,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.password,
                              color: Palette.primary,
                            ),
                            suffixIcon: const Icon(
                              Icons.visibility,
                              color: Palette.primary,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(36),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(36),
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    loginButton(height, context),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Üye Değil Misin ? Hemen Üye Ol",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          )),
                    )
                  ],
                ),
              );
            } else if (state is LoginLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (state is LoginFinished) {
              if (state.loginResponseData.success == true) {
                print(state.loginResponseData.data!.token.toString() + "SELAM");
                print(state.loginResponseData.success);
                return HomePage();
              } else {
                return Container(
                  child: Text("Hata Oluştu"),
                );
              }
            } else {
              return Text("Error");
            }
          },
        ),
*/