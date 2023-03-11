import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/component/storage_const.dart';
import 'package:tec/services/dio_service.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/register/register_intro.dart';

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
    var status = response.data['response'];

    // if (status == 'verified') {

    // } else {
    //   log('error');
    // }
    switch (status) {
      case 'verified':
        var box = GetStorage();
        box.write(token, response.data['token']);
        box.write(userId, response.data['user_id']);

        Get.offAll(() =>  MainScreen());
        // debugPrint('read....${box.read(token)}');
        // debugPrint('read....${box.read(userId)}');
        break;
      case 'incorrect_code':
        Get.snackbar(
          'خطا',
          'کد فعالسازی غلط است',
        );
        break;
      case 'expired':
        Get.snackbar('خطا', 'کد فعالسازی منقضی شده است');
        break;
    }
  }

  toggleLogin() {
    if (GetStorage().read(token) == null) {
      Get.to(RegisterIntro());
    } else {
      debugPrint('post screen');
    }
  }
}
//TODO fix snackbar issue https://www.youtube.com/watch?v=jqm_YahHU5k