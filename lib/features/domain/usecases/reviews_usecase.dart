import 'package:cubit_mvvm_clean/core/failures_succeses/failures.dart';
import 'package:cubit_mvvm_clean/core/services/services_locator.dart';
import 'package:cubit_mvvm_clean/features/domain/repositories/reviewsRepository.dart';
import 'package:dartz/dartz.dart';

import '../entities/login.dart';

class ReviewsUseCase {
  final ReviewsRepository reviewsRepository = instance<ReviewsRepository>();

  Future<Either<Failure, ReviewsResponseData>> getReviews() {
    return reviewsRepository.GetReviews();
  }

  Future<bool> sendAnswer(
      int choiceId,int questionId,String text,String city,String disctrict,String neighborhood) {
    return reviewsRepository.sendAnswer(choiceId, questionId, text,city,disctrict,neighborhood);
  }
}
