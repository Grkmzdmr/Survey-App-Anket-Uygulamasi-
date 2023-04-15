class LoginResponse {
  final String? token;
  final bool? success;

  const LoginResponse({this.token, this.success});
}

class LoginResponseData {
  final String? data;
  final bool? success;
  const LoginResponseData({this.data, this.success});
}

class ReviewsResponse {
  final int? id;
  final String? name;
  final int? questionCount;

  const ReviewsResponse({this.id, this.name, this.questionCount});
}

class ReviewsResponseData {
  final List<ReviewsResponse>? data;
  final bool? success;

  ReviewsResponseData({this.data, this.success});
}

class QuestionsResponse {
  final int? id;
  final String? text;
  final int? surveyId;
  final int? questionType;
  final List<ChoiceResponse>? choices;

  QuestionsResponse(
      {this.id, this.text, this.surveyId, this.questionType, this.choices});
}

class QuestionsResponseData {
  final List<QuestionsResponse>? data;
  final bool? success;

  QuestionsResponseData({this.data, this.success});
}

class ChoiceResponse {
  final int? id;
  final String? text;
  final int? questionId;

  ChoiceResponse({this.id, this.text, this.questionId});
}
