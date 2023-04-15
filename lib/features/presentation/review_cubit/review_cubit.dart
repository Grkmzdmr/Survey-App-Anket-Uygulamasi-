import 'package:cubit_mvvm_clean/core/failures_succeses/failures.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/login.dart';
import 'package:cubit_mvvm_clean/features/domain/usecases/questions_usecase.dart';
import 'package:cubit_mvvm_clean/features/domain/usecases/reviews_usecase.dart';
import 'package:dartz/dartz.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../core/services/services_locator.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewInitial());

  final QuestionsUseCase _questionsUseCase = instance<QuestionsUseCase>();
  final ReviewsUseCase _reviewsUseCase = instance<ReviewsUseCase>();
  final regionBox = Hive.box("regionBox");
  final smallRegionBox = Hive.box("smallRegionBox");

  void getQuestions(int surveyId) async {
    emit(ReviewLoading());
    final Either<Failure, QuestionsResponseData> questionResult =
        await _questionsUseCase.getQuestions(surveyId);
    questionResult.fold((l) {
      emit(ReviewError());
      print(l.message);
    }, (r) {
      emit(ReviewFinished(questionsResponseData: r));
    });
  }

  void sendAnswer(List<QuestionsResponse> data, List<String> texts,
      List<int> choices) async {
    emit(AnswerSendingLoading());
    bool result = false;
    String regionString = regionBox.get("regionBox");
    String smallRegionString = smallRegionBox.get("smallRegionBox");

    for (int i = 0; i < data.length; i++) {
      if (data[i].questionType == 1) {
        result = await _reviewsUseCase.sendAnswer(
            0, data[i].id!, texts[i], "Aydın", regionString, smallRegionString);
      } else {
        if (data[i].choices!.length < 2) {
          result = true;
        } else {
          result = await _reviewsUseCase.sendAnswer(choices[i], data[i].id!, "",
              "Aydın", regionString, smallRegionString);
        }
      }
    }

    if (result) {
      emit(AnswerSendCompletely());
    } else {
      emit(AnswerSendError());
    }
  }
}
