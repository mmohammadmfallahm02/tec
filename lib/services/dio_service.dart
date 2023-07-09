// ignore_for_file: body_might_complete_normally_catch_error, duplicate_ignore

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/storage_const.dart';

class DioService {
  Dio dio = Dio();

  Future<dynamic> getMethod(String url) async {
    dio.options.headers['content_type'] = 'application/json';
    return await dio
        .get(url,
            options: Options(
              responseType: ResponseType.json,
              method: 'GET',
            ))
        .then((response) {
      // log(response.toString());
      return response;
    }).catchError((error) {
      if (error is DioError) {
        return error.response!;
      }
    });
  }

  Future<dynamic> postMethod(Map<String, dynamic> map, String url) async {
    dio.options.headers['content_type'] = 'application/json';
    var token = GetStorage().read(StorageKey.token);
    if (token != null) {
      dio.options.headers['authorization'] = '$token';
    
    }
    
    return await dio
        .post(url,
            data: dio_service.FormData.fromMap(map),
            options: Options(responseType: ResponseType.json, method: 'POST'))
        .then((response) {
      return response;
    // ignore: body_might_complete_normally_catch_error
    }).catchError((error) {
       log(error.toString());
      if (error is DioError) {
        return error.response!;
      }
    });
  }
}

