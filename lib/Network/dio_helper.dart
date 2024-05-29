//dio

import 'package:dio/dio.dart';

class Dio_helper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        //receiveTimeout: Duration(milliseconds: 400000),
        //connectTimeout: Duration(milliseconds: 20000),
        //receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> Postdata({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lnag = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lnag,
      'Authorization': token ?? '',
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> Getdata({
    required String url,
    Map<String, dynamic>? query,
    String lnag = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lnag,
      'Authorization': token ?? '',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
}
