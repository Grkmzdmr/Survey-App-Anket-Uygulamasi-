import 'package:cubit_mvvm_clean/core/failures_succeses/failures.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/login.dart';
import 'package:dartz/dartz.dart';

abstract class QuestionsRepository {
  Future<Either<Failure, QuestionsResponseData>> getQuestions(int surveyId);
}
