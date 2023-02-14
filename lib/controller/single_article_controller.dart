import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/services/dio_service.dart';

class SingleArticleController extends GetxController {
  RxInt id = RxInt(0);
  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
  }

  getArticleInfo() async {
    loading.value = true;

    var response = await DioService().getMethod(ApiConstant.getArticleList);
    if (response.statusCode == 200) {
      response.data.forEach((element) {});
    }
    loading.value = false;
  }
}
