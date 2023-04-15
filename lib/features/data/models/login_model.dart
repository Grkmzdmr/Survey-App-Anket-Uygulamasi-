import 'package:cubit_mvvm_clean/features/domain/entities/login.dart';

class LoginModel extends LoginResponse {
  LoginModel({String? token, bool? success}) : super(token: token);

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      token: map['token'],
    );
  }
}

class LoginModelData extends LoginResponseData {
  LoginModelData({String? data, bool? success})
      : super(data: data, success: success);

  factory LoginModelData.fromMap(Map<String, dynamic> map) {
    return LoginModelData(
      data: map['data'],
      success: map['success'],
    );
  }
}

class ReviewsModel extends ReviewsResponse {
  ReviewsModel({int? id, String? name,int? questionCount}) : super(id: id, name: name,questionCount:questionCount);

  factory ReviewsModel.fromMap(Map<String, dynamic> map) {
    return ReviewsModel(id: map['id'], name: map['name'],questionCount: map['questionCount']);
  }
}

class ReviewsModelData extends ReviewsResponseData {
  ReviewsModelData({List<ReviewsModel>? data, bool? success})
      : super(data: data, success: success);

  factory ReviewsModelData.fromMap(Map<String, dynamic> map) {
    var list = map['data'] as List;
    List<ReviewsModel> itemsList =
        list.map((i) => ReviewsModel.fromMap(i)).toList();

    return ReviewsModelData(
      data: itemsList,
      success: map['success'],
    );
  }
}

class ChoiceModel extends ChoiceResponse {
  ChoiceModel({int? id, String? text, int? questionId})
      : super(id: id, text: text, questionId: questionId);

  factory ChoiceModel.fromMap(Map<String, dynamic> map) {
    return ChoiceModel(
        id: map['id'], text: map['text'], questionId: map['questionId']);
  }
}

class QuestionsModel extends QuestionsResponse {
  QuestionsModel(
      {int? id,
      String? text,
      int? surveyId,
      int? questionType,
      List<ChoiceResponse>? choices})
      : super(
            id: id,
            text: text,
            surveyId: surveyId,
            questionType: questionType,
            choices: choices);

  factory QuestionsModel.fromMap(Map<String, dynamic> map) {
    var list = map['choices'] as List;
    List<ChoiceResponse> choicesList =
        list.map((i) => ChoiceModel.fromMap(i)).toList();
    return QuestionsModel(
        id: map['id'],
        text: map['text'],
        surveyId: map['surveyId'],
        questionType: map['questionType'],
        choices: choicesList);
  }
}

class QuestionsModelData extends QuestionsResponseData {
  QuestionsModelData({List<QuestionsResponse>? data, bool? success})
      : super(data: data, success: success);

  factory QuestionsModelData.fromMap(Map<String, dynamic> map) {
    var list = map['data'] as List;
    List<QuestionsResponse> itemsList =
        list.map((i) => QuestionsModel.fromMap(i)).toList();

    return QuestionsModelData(
      data: itemsList,
      success: map['success'],
    );
  }
}
