import 'dart:convert';

import 'package:cubit_mvvm_clean/core/services/services_locator.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

abstract class ApiService {
  Future<Map<String, dynamic>> getData(
      String url, Map<String, dynamic> queryParams);
}

class ApiServiceImpl implements ApiService {
  final Dio _dio = instance<Dio>();

  @override
  Future<Map<String, dynamic>> getData(
      String url, Map<String, dynamic> queryParams) async {
    final Response response = await _dio.post(url,
        data: jsonEncode(queryParams),
        options: Options(headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        }));

    // final http.Response response = await http.post(Uri.parse(url),
    //     body: jsonEncode(queryParams),
    //     headers: {
    //       "Accept": "application/json",
    //       "content-type": "application/json"
    //     });

    if (response.statusCode == 200) {
      print(response.data);
      
      return response.data;
    } else {
      throw Exception("Status code:" + response.statusCode.toString());
    }
  }
}
