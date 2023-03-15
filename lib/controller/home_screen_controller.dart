import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/podcast_model.dart';
import 'package:tec/models/poster_model.dart';
import 'package:tec/models/tag_model.dart';
import 'package:tec/services/dio_service.dart';

class HomeScreenController extends GetxController {
  Rx<PosterModel> poster = PosterModel().obs;
  RxList<TagModel> tagsList = RxList();
  RxList<ArticleModel> topVisitedList = RxList();
  RxList<PodcastModel> topPodcasts = RxList();
  RxBool loading = false.obs;
  @override
  onInit() {
    super.onInit();
    getHomeItem();
  }

  getHomeItem() async {
    loading.value = true;
    var response = await DioService().getMethod(ApiConstant.getHomeItem);

    if (response.statusCode == 200) {
      poster.value = PosterModel.fromJson(response.data['poster']);

      response.data['top_visited'].forEach(
        (element) => topVisitedList.add(ArticleModel.fromJson(element)),
      );

      response.data['top_podcasts'].forEach(
        (element) => topPodcasts.add(PodcastModel.fromJson(element)),
      );

      response.data['tags'].forEach(
        (element) => tagsList.add(TagModel.fromJson(element)),
      );

      loading.value = false;
    }
  }
}
