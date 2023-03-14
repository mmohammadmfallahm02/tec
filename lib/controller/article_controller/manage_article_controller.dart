import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/component/storage_const.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/tag_model.dart';
import '../../component/api_constant.dart';
import '../../services/dio_service.dart';

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList.empty();
  RxList<TagModel> tagList = RxList.empty();

  RxBool loading = false.obs;
  Rx<ArticleInfoModel> articleModel = ArticleInfoModel(
    title: 'اینجا عنوان مقاله قرار میگیره ، یه عنوان جذاب انتخاب کن',
    content:
        'من متن و بدنه اصلی مقاله هستم ، اگه میخوای من رو ویرایش کنی و یه مقاله جذاب بنویسی ، نوشته آبی رنگ بالا که نوشته "ویرایش متن اصلی مقاله" رو با انگشتت لمس کن تا وارد ویرایشگر بشی',
    image: ' ',
  ).obs;

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
