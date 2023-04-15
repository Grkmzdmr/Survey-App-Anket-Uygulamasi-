import 'package:cubit_mvvm_clean/core/failures_succeses/exceptions.dart';
import 'package:cubit_mvvm_clean/core/failures_succeses/failures.dart';
import 'package:cubit_mvvm_clean/core/services/services_locator.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/login.dart';
import 'package:cubit_mvvm_clean/features/domain/repositories/reviewsRepository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data_sources/remote_datasource.dart';

class ReviewsRepoImpl implements ReviewsRepository {
  final RemoteDataSource remoteDataSource = instance<RemoteDataSource>();

  @override
  Future<Either<Failure, ReviewsResponseData>> GetReviews() async {
    try {
      return Right(await remoteDataSource.getReviews());
    } on LoginException catch (e) {
      return Left(FetchFailure(message: e.message));
    }
  }

  @override
  Future<bool> sendAnswer(int choiceId,int questionId,String text,String city,String disctrict,String neighborhood) async {
    try {
      bool response =
          await remoteDataSource.sendAnswer(choiceId, questionId, text,city,disctrict,neighborhood);
      return response;
    } on LoginException catch (e) {
      return false;
    }
  }
}
