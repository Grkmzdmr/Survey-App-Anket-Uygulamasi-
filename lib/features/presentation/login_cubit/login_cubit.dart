import 'package:bloc/bloc.dart';
import 'package:cubit_mvvm_clean/core/failures_succeses/failures.dart';
import 'package:cubit_mvvm_clean/core/services/services_locator.dart';
import 'package:cubit_mvvm_clean/features/data/models/login_model.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/login.dart';
import 'package:cubit_mvvm_clean/features/domain/usecases/login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.usernameController, this.passwordController, this.formKey) : super(LoginInitial());
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  final LoginUseCase _loginUseCase = instance<LoginUseCase>();

  void login(String? sign, String? password, String? deviceId,
      int userDeviceTypeId) async {
    emit(LoginLoading());
    final Either<Failure, LoginResponseData> loginResult =
        await _loginUseCase.login(sign, password, deviceId, userDeviceTypeId);
    loginResult.fold((l) {
      emit(LoginError());
      print(l.message);
    }, (r) {
      emit(LoginFinished(loginResponseData: r));
    });
  }
}
