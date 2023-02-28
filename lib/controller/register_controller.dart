import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/component/storage_const.dart';
import 'package:tec/services/dio_service.dart';
import 'package:tec/view/main_screen/main_screen.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController activeCodeController = TextEditingController();
  var email = '';
  var userId = '';

  register() async {
    Map<String, dynamic> map = {
      'email': emailController.text,
      'command': 'register'
    };

    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    email = emailController.text;
    userId = response.data['user_id'];
    // debugPrint(response);
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activeCodeController.text,
      'command': 'verify'
    };
    // debugPrint(map.toString());
    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    // debugPrint(response.data);

    if (response.data['response'] == 'verified') {
      var box = GetStorage();
      box.writeIfNull(token, response.data['token']);
      box.writeIfNull(userId, response.data['user_id']);

      Get.to(MainScreen());
      // debugPrint('read....${box.read(token)}');
      // debugPrint('read....${box.read(userId)}');
    } else {
      log('error');
    }
  }
}
