import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_do/model/local_db/local_db.dart';
import 'package:easy_do/model/remote_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/models/login_model.dart';

class AuthenticationController extends ChangeNotifier {
  final Dio dio = Dio();
  bool isLoading = false;
  bool isSignupLoading = false;

  Future<Response> postData(String url, dynamic data) => dio.post(
        url,
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
          sendTimeout: const Duration(milliseconds: 10000),
          receiveTimeout: const Duration(milliseconds: 10000),
        ),
      );

  Future<LoginModel?> getUserLoggedIn(dynamic data) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await postData(RemoteUtils.login, data);

      if (response.statusCode == 200) {
        isLoading = false;
        notifyListeners();

        UserData.setAccessToken(LoginModel.fromJson(response.data).token);

        log(response.data.toString());

        return LoginModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      isLoading = false;
      notifyListeners();
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        print('Timeout error');
      } else if (e.type == DioExceptionType.badResponse) {
        print('Response error: ${e.response?.statusCode}');
        if (e.response?.statusCode == 400) {}
      } else if (e.type == DioExceptionType.cancel) {
        print('Request cancelled');
      } else {
        print('Other error: $e');
      }
    }
    isLoading = false;
    notifyListeners();
    return null;
  }

  Future<LoginModel?> getUserSignUp(dynamic data) async {
    isSignupLoading = true;
    notifyListeners();
    try {
      final response = await postData(RemoteUtils.signup, data);

      if (response.statusCode == 200) {
        isSignupLoading = false;
        notifyListeners();

        UserData.setAccessToken(LoginModel.fromJson(response.data).token);

        log(response.data.toString());

        return LoginModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      isSignupLoading = false;
      notifyListeners();
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        print('Timeout error');
      } else if (e.type == DioExceptionType.badResponse) {
        print('Response error: ${e.response?.statusCode}');
        print('Response: ${e.response?.data}');
        if (e.response?.statusCode == 400) {}
      } else if (e.type == DioExceptionType.cancel) {
        print('Request cancelled');
      } else {
        print('Other error: $e');
      }
    }
    isSignupLoading = false;
    notifyListeners();
    return null;
  }
}

final authenticationProvider =
    ChangeNotifierProvider<AuthenticationController>((ref) {
  return AuthenticationController();
});
