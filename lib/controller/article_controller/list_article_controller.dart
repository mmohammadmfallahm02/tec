
import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
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

    // TODO get userId from getStorage ApiConstant.getArticleList+userId
    var response = await DioService().getMethod(ApiUrlConstant.getArticleList);
    if (response.statusCode == 200) {
      response.data.forEach(
          (element) => articleList.add(ArticleModel.fromJson(element)));
    }
    loading.value = false;
  }

  getArticleListWithTagId(String id) async {
    articleList.clear();
    loading.value = true;

    // TODO get userId from getStorage ApiConstant.getArticleList+userId
    final queryParam = {
      'command': 'get_articles_with_tag_id',
      'tag_id': id,
      'user_id': ''
    };
    final uri = Uri.https("techblog.sasansafari.com",
        "/Techblog/api/article/get.php", queryParam);
    var response = await DioService().getMethod(uri.toString());
    if (response.statusCode == 200) {
      response.data.forEach(
          (element) => articleList.add(ArticleModel.fromJson(element)));
    }
    loading.value = false;
  }
}
