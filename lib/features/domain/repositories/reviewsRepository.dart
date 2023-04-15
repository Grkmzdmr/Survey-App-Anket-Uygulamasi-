import 'package:cubit_mvvm_clean/core/failures_succeses/failures.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/login.dart';
import 'package:dartz/dartz.dart';

abstract class ReviewsRepository {
  Future<Either<Failure, ReviewsResponseData>> GetReviews();
  Future<bool> sendAnswer(int choiceId,int questionId,String text,String city,String disctrict,String neighborhood);
}
