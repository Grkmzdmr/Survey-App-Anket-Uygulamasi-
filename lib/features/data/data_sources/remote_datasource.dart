import 'dart:convert';

import 'package:cubit_mvvm_clean/core/constants/strings.dart';
import 'package:cubit_mvvm_clean/core/failures_succeses/exceptions.dart';
import 'package:cubit_mvvm_clean/core/services/api_service.dart';
import 'package:cubit_mvvm_clean/core/services/services_locator.dart';
import 'package:cubit_mvvm_clean/features/data/models/login_model.dart';
import 'package:flutter/material.dart';

abstract class RemoteDataSource {
  Future<LoginModelData> login(
      String? sign, String? password, String? deviceId, int userDeviceTypeId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiService apiService = instance<ApiService>();

  @override
  Future<LoginModelData> login(String? sign, String? password, String? deviceId,
      int userDeviceTypeId) async {
    try {
      Map<String, dynamic> data = await apiService.getData(Strings.loginUrl, {
        'sign': '$sign',
        'password': '$password',
        'deviceId': '$deviceId',
        'userDeviceTypeId': '$userDeviceTypeId'
      });

      // Map<String, dynamic> list = data;
      //List<Map<String, dynamic>> mapList = [];

      // for (int i = 0; i < list.length; i++) {
      //   Map<String, dynamic> map = list[i] as Map<String, dynamic>;
      //   mapList.add(map);
      // }

      LoginModel loginModel = LoginModel.fromMap(data['data']);
      LoginModelData loginModelData = LoginModelData.fromMap(data);
      return loginModelData;
    } catch (e) {
      print(e);
      throw const LoginException(message: "Failed to get data");
    }
  }
}
