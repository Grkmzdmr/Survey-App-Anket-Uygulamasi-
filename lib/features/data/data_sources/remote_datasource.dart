import 'dart:convert';

import 'package:cubit_mvvm_clean/core/constants/strings.dart';
import 'package:cubit_mvvm_clean/core/failures_succeses/exceptions.dart';
import 'package:cubit_mvvm_clean/core/services/api_service.dart';
import 'package:cubit_mvvm_clean/core/services/services_locator.dart';
import 'package:cubit_mvvm_clean/features/data/models/login_model.dart';
import 'package:cubit_mvvm_clean/features/domain/entities/login.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class RemoteDataSource {
  Future<LoginModelData> login(String? sign, String? password);
  Future<ReviewsResponseData> getReviews();
  Future<QuestionsResponseData> getQuestion(int surveyId);
  Future<bool> sendAnswer(int choiceId, int questionId, String text,
      String city, String disctrict, String neighborhood);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiService apiService = instance<ApiService>();

  @override
  Future<LoginModelData> login(String? sign, String? password) async {
    try {
      Map<String, dynamic> data = await apiService.getData(Strings.loginUrl, {
        'name': '$sign',
        'password': '$password',
      });

      // Map<String, dynamic> list = data;
      //List<Map<String, dynamic>> mapList = [];

      // for (int i = 0; i < list.length; i++) {
      //   Map<String, dynamic> map = list[i] as Map<String, dynamic>;
      //   mapList.add(map);
      // }

      //LoginModel loginModel = LoginModel.fromMap(data['data']);
      LoginModelData loginModelData = LoginModelData.fromMap(data);
      return loginModelData;
    } catch (e) {
      print(e);
      throw const LoginException(message: "Failed to get data");
    }
  }

  @override
  Future<ReviewsResponseData> getReviews() async {
    try {
      Map<String, dynamic> data =
          await apiService.getDataWithGet(Strings.getReviewsUrl);

      print(data);
      ReviewsModelData reviewsModel = ReviewsModelData.fromMap(data);

      return reviewsModel;
    } catch (e) {
      throw const LoginException(message: "Failed to get data");
    }
  }

  @override
  Future<QuestionsResponseData> getQuestion(int surveyId) async {
    try {
      String url = Strings.getQuestions + surveyId.toString();
      Map<String, dynamic> data = await apiService.getDataWithGet(url);

      print(data);

      QuestionsModelData questionModel = QuestionsModelData.fromMap(data);
      return questionModel;
    } catch (e) {
      throw const LoginException(message: "Failed to get data");
    }
  }

  @override
  Future<bool> sendAnswer(int choiceId, int questionId, String text,
      String city, String disctrict, String neighborhood) async {
    try {
      String url = Strings.addAnswer +
          questionId.toString() +
          "/:" +
          choiceId.toString();
      bool data = await apiService.postWithToken(url, {
        'text': text,
        'city': city,
        'district': disctrict,
        'neighborhood': neighborhood
      });

      print(data);

      return data;
    } catch (e) {
      throw const LoginException(message: "Failed to get data");
    }
  }
}
