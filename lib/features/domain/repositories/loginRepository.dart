import 'package:cubit_mvvm_clean/core/failures_succeses/failures.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/login.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginResponseData>> login(
      String? sign, String? password, String? deviceId, int userDeviceTypeId);
}
