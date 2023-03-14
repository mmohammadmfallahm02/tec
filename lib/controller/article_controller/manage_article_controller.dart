import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/component/storage_const.dart';
import 'package:tec/models/article_model.dart';
import '../../component/api_constant.dart';
import '../../services/dio_service.dart';

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList.empty();
  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getManageArticle();
  }

  getManageArticle() async {
    loading.value = true;

    // TODO get userId from getStorage ApiConstant.getArticleList+userId
    // var response = await DioService().getMethod(
    //     ApiConstant.getArticlePublishedByMe +
    //         GetStorage().read(StorageKey.userId));
    var response =
        await DioService().getMethod('${ApiConstant.getArticlePublishedByMe}1');
    if (response.statusCode == 200) {
      response.data.forEach(
          (element) => articleList.add(ArticleModel.fromJson(element)));
    }
    loading.value = false;
    // articleList.clear();
  }
}
