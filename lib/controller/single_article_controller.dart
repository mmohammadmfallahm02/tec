import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/tag_model.dart';
import 'package:tec/services/dio_service.dart';

class SingleArticleController extends GetxController {
  RxInt id = RxInt(0);
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel().obs;
  RxList<TagModel> tagsList = RxList();
  RxList<ArticleModel> relatedArticle = RxList();
  RxBool loading = false.obs;

  getArticleInfo() async {
    articleInfoModel = ArticleInfoModel().obs;
    loading.value = true;
    // TODO user id is hard code
    var userId = '';
    var response = await DioService().getMethod(
        '${ApiConstant.baseUrl}article/get.php?command=info&id=$id&user_id=$userId');
    if (response.statusCode == 200) {
      articleInfoModel.value = ArticleInfoModel.fromJson(response.data);
      tagsList.clear();
      response.data['tags'].forEach((element) {
            return tagsList.add(TagModel.fromJson(element));
          }) ??
          [];
      relatedArticle.clear();
      response.data['related'].forEach((element) {
            return relatedArticle.add(ArticleModel.fromJson(element));
          }) ??
          [];
    }
    loading.value = false;
  }
}
