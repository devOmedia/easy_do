import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationController extends ChangeNotifier {
  final Dio dio = Dio();

  Future<Response> postData(String url, dynamic data) => dio.post(
        url,
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
          sendTimeout: const Duration(milliseconds: 10000),
          receiveTimeout: const Duration(milliseconds: 10000),
        ),
      );

  
}
