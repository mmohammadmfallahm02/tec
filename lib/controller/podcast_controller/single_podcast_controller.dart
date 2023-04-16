import 'dart:developer';

import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/podcast_file_model.dart';
import 'package:tec/services/dio_service.dart';

class SinglePodcastController extends GetxController {
  var id;
  SinglePodcastController({required this.id});

  RxBool loading = false.obs;
  Rx<PodcastFileModel> podcastFileModel = PodcastFileModel().obs;
  RxList<PodcastFileModel> podcastEpisodes = RxList();

  @override
  onInit() {
    super.onInit();
    getPodcastEpisodes();
    
  }

  getPodcastEpisodes() async {
    loading.value = true;
    var response =
        await DioService().getMethod("${ApiUrlConstant.podcastEpisodes}$id");
    if (response.statusCode == 200) {
      for (var episode in response.data['files']) {
        podcastEpisodes.add(PodcastFileModel.fromJson(episode));
      }
      loading.value = false;
    }
  }
}
