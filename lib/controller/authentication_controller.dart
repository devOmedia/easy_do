import 'package:dio/dio.dart';
import 'package:easy_do/model/remote_utils.dart';
import 'package:flutter/cupertino.dart';

import '../model/models/login_model.dart';

class AuthenticationController extends ChangeNotifier {
  final Dio dio = Dio();
  bool isLoading = false;

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
      final response = await postData("${RemoteUtils.login}", data);

      if (response.statusCode == 200) {
        isLoading = false;
        notifyListeners();

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
        if (e.response?.statusCode == 400) {
          return LoginModel.fromJson(e.response?.data);
        }
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
}
