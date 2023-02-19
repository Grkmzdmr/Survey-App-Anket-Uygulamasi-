import 'package:cubit_mvvm_clean/core/failures_succeses/exceptions.dart';
import 'package:cubit_mvvm_clean/core/services/services_locator.dart';
import 'package:cubit_mvvm_clean/features/data/data_sources/remote_datasource.dart';
import 'package:cubit_mvvm_clean/features/data/models/login_model.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/login.dart';
import 'package:cubit_mvvm_clean/core/failures_succeses/failures.dart';
import 'package:cubit_mvvm_clean/features/domain/repositories/loginRepository.dart';
import 'package:dartz/dartz.dart';

class LoginRepoImpl implements LoginRepository {
  final RemoteDataSource remoteDataSource = instance<RemoteDataSource>();

  @override
  Future<Either<Failure, LoginModelData>> login(String? sign, String? password,
      String? deviceId, int userDeviceTypeId) async {
    try {
      return Right(await remoteDataSource.login(
          sign, password, deviceId, userDeviceTypeId));
    } on LoginException catch (e) {
      return Left(FetchFailure(message: e.message));
    }
  }
}
