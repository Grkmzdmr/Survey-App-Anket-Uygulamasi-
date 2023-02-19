import 'package:cubit_mvvm_clean/core/failures_succeses/failures.dart';
import 'package:cubit_mvvm_clean/core/services/services_locator.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/login.dart';
import 'package:cubit_mvvm_clean/features/domain/repositories/loginRepository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  final LoginRepository loginRepository = instance<LoginRepository>();

  Future<Either<Failure, LoginResponseData>> login(
      String? sign, String? password, String? deviceId, int userDeviceTypeId) {
    return loginRepository.login(sign, password, deviceId, userDeviceTypeId);
  }
}
