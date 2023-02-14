import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/services/dio_service.dart';

class ListArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getArticleList();
  }

  getArticleList() async {
    loading.value = true;

    // TODO get userid from getStorage ApiConstant.getArticleList+userId
    var response = await DioService().getMethod(ApiConstant.getArticleList);
    if (response.statusCode == 200) {
      response.data.forEach(
          (element) => articleList.add(ArticleModel.fromJson(element)));
    }
    loading.value = false;
  }
}
