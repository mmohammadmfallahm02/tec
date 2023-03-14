import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/component/storage_const.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/main.dart';
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
        box.write(StorageKey.token, response.data['token']);
        box.write(StorageKey.userId, response.data['user_id']);

        Get.offAll(() => MainScreen());
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
    if (GetStorage().read(StorageKey.token) == null) {
      Get.to(RegisterIntro());
    } else {
      routeToRightBottomSheet();
    }
  }

  routeToRightBottomSheet() {
    Get.bottomSheet(Container(
      height: Get.height / 3,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.images.tcbot.svg(height: 50),
              const SizedBox(
                width: 20,
              ),
              const Text('دونسته هات رو با بقیه به اشتراک بذار ...')
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            '''فکر کن !!  اینجا بودنت به این معناست که یک گیک تکنولوژی هستی دونسته هات رو با  جامعه‌ی گیک های فارسی زبان به اشتراک بذار..''',
            textAlign: TextAlign.justify,
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buttonToWriteContent(
                  onTap: () {
                    // debugPrint('write article');
                    // Get.to(ManageArticle());
                    Get.toNamed(NamedRoute.routeManageArticleScreen);
                  },
                  icon: Assets.icons.writeArticle.image(width: 30),
                  title: 'مدیریت مقاله ها'),
              buttonToWriteContent(
                  onTap: () {
                    debugPrint('write podcast');
                  },
                  icon: Assets.icons.writeMicrophone.image(width: 30),
                  title: 'مدیریت پادکست ها'),
            ],
          )
        ]),
      ),
    ));
  }

  GestureDetector buttonToWriteContent(
      {Function()? onTap, required String title, required Image icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 8,
            ),
            const Text('مدیریت پادکست ها')
          ],
        ),
      ),
    );
  }
}
//TODO fix snackbar issue https://www.youtube.com/watch?v=jqm_YahHU5k