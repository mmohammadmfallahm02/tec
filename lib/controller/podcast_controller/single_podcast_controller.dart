import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/podcast_file_model.dart';
import 'package:tec/services/dio_service.dart';

class SinglePodcastController extends GetxController {
  var id;
  SinglePodcastController({required this.id});

  RxBool loading = false.obs;
  Rx<PodcastFileModel> podcastFileModel = PodcastFileModel().obs;
  RxList<PodcastFileModel> podcastEpisodes = RxList();
  RxBool playState = false.obs;
  RxInt currentFileIndex = 0.obs;
  final player = AudioPlayer();
  late var playList;
  Rx<Duration> progressValue = const Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = const Duration(seconds: 0).obs;
  Timer? timer;
  RxBool isLoopAll = false.obs;
  @override
  onInit() async {
    super.onInit();
    playList = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: [],
    );
    await player.setAudioSource(playList,
        initialIndex: 0, initialPosition: Duration.zero);
    await getPodcastEpisodes();
  }

  getPodcastEpisodes() async {
    loading.value = true;
    var response =
        await DioService().getMethod("${ApiUrlConstant.podcastEpisodes}$id");
    if (response.statusCode == 200) {
      for (var episode in response.data['files']) {
        var podcastFileModel = PodcastFileModel.fromJson(episode);
        podcastEpisodes.add(podcastFileModel);
        playList.add(AudioSource.uri(Uri.parse(podcastFileModel.file!)));
      }
      loading.value = false;
    }
  }

  startProgress() {
    const tick = Duration(seconds: 1);
    var duration = (player.duration!.inSeconds) - player.position.inSeconds;
    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
        timer = null;
      }
    }
    timer = Timer.periodic(tick, (timer) {
      duration--;
      progressValue.value = player.position;
      bufferedValue.value = player.bufferedPosition;
      if (duration <= 0) {
        timer.cancel();
        progressValue.value = Duration.zero;
        bufferedValue.value = Duration.zero;
      }
    });
  }

  setLoopMode() {
    if (isLoopAll.value == true) {
      isLoopAll.value = false;
      player.setLoopMode(LoopMode.off);
    } else {
      isLoopAll.value = true;
      player.setLoopMode(LoopMode.all);
    }
  }
}
