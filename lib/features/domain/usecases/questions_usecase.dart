import 'package:cubit_mvvm_clean/core/failures_succeses/failures.dart';
import 'package:cubit_mvvm_clean/core/services/services_locator.dart';
import 'package:cubit_mvvm_clean/features/domain/repositories/questionsRepository.dart';
import 'package:dartz/dartz.dart';

import '../entities/login.dart';

class QuestionsUseCase {
  final QuestionsRepository questionsRepository = instance<QuestionsRepository>();

  Future<Either<Failure, QuestionsResponseData>> getQuestions(int surveyId) {
    return questionsRepository.getQuestions(surveyId);
  }

  

}
