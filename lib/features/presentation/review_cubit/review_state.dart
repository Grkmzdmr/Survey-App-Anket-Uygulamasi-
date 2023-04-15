part of 'review_cubit.dart';

@immutable
abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class ReviewLoading extends ReviewState {}

class ReviewError extends ReviewState {}

class ReviewFinished extends ReviewState {
  // final ReviewsResponseData reviewResponseData;
  final QuestionsResponseData questionsResponseData;

  ReviewFinished({required this.questionsResponseData});
}

class AnswerSendCompletely extends ReviewState{

}

class AnswerSendError extends ReviewState{

}

class AnswerSendingLoading extends ReviewState{
  
}
