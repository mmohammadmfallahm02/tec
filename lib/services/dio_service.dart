import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:tec/component/api_constant.dart';

class DioService {
  Future<dynamic> getMethod(String url) async {
    Dio dio = Dio(BaseOptions(baseUrl: ApiConstant.baseUrl));
    dio.options.headers['content_type'] = 'application/json';
    return await dio
        .get(url,
            options: Options(
              responseType: ResponseType.json,
              method: 'GET',
            ))
        .then((response) {
      log(response.toString());
      return response;
    });
  }
}
