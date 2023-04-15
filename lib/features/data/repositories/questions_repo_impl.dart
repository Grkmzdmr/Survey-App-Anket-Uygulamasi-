import 'package:cubit_mvvm_clean/core/failures_succeses/exceptions.dart';
import 'package:cubit_mvvm_clean/core/failures_succeses/failures.dart';
import 'package:cubit_mvvm_clean/core/services/services_locator.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/login.dart';
import 'package:cubit_mvvm_clean/features/domain/repositories/questionsRepository.dart';
import 'package:dartz/dartz.dart';

import '../data_sources/remote_datasource.dart';

class QuestionsRepoImpl implements  QuestionsRepository{
  final RemoteDataSource remoteDataSource = instance<RemoteDataSource>();

  @override
  Future<Either<Failure, QuestionsResponseData>> getQuestions(int surveyId) async{
     try {
      return Right(await remoteDataSource.getQuestion(surveyId
          ));
    } on LoginException catch (e) {
      return Left(FetchFailure(message: e.message));
    }
  }

 

 
  
}