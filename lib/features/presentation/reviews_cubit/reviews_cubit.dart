import 'package:cubit_mvvm_clean/core/failures_succeses/failures.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/login.dart';
import 'package:cubit_mvvm_clean/features/domain/usecases/reviews_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/services_locator.dart';
import '../../domain/usecases/login_usecase.dart';

part 'reviews_state.dart';

class ReviewsCubit extends Cubit<ReviewsState> {
  ReviewsCubit() : super(ReviewsInitial());


  

  final ReviewsUseCase _reviewsUseCase = instance<ReviewsUseCase>();


   void getReviews() async {
    emit(ReviewsLoading());
    final Either<Failure, ReviewsResponseData> loginResult =
        await _reviewsUseCase.getReviews();
    loginResult.fold((l) {
      emit(ReviewsError());
      print(l.message);
    }, (r) {
      emit(ReviewsFinished(reviewResponseData: r));
    });
  }

  
}
