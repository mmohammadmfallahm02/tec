// ignore_for_file: deprecated_member_use

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tec/component/decorations.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/controller/podcast_controller/single_podcast_controller.dart';
import 'package:tec/models/podcast_model.dart';
import '../../component/my_component.dart';
import '../../constant/my_color.dart';
import '../../gen/assets.gen.dart';
import '../../models/podcast_file_model.dart';

// ignore: must_be_immutable
class SinglePodcast extends StatelessWidget {
  late SinglePodcastController controller;
  late PodcastModel podcastModel;
  SinglePodcast({super.key}) {
    podcastModel = Get.arguments;
    controller = Get.put(SinglePodcastController(id: podcastModel.id));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: Get.height / 3,
                            width: double.infinity,
                            child: CachedNetworkImage(
                                imageUrl: podcastModel.poster!,
                                imageBuilder: (context, imageProvider) => Image(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                placeholder: (context, url) => const Loading(),
                                errorWidget: (context, url, error) =>
                                    Assets.images.singlePlaceHolder.image()),
                          ),
                          Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 60,
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: GradientColors
                                            .articleSingleAppBarGradient,
                                        end: Alignment.bottomCenter,
                                        begin: Alignment.topCenter)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    GestureDetector(
                                      onTap: () => Get.back(),
                                      child: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Expanded(child: SizedBox()),
                                    GestureDetector(
                                      onTap: () async {
                                        await Share.share(
                                            'this is just for test');
                                      },
                                      child: const Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          podcastModel.title!,
                          maxLines: 2,
                          style: themeData.textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Assets.images.profileAvatar.image(width: 50),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              podcastModel.author!,
                              style: themeData.textTheme.headline4,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                      Obx(
                        () => ListView.builder(
                            itemCount: controller.podcastEpisodes.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final PodcastFileModel episode =
                                  controller.podcastEpisodes[index];
                              return GestureDetector(
                                onTap: () async {
                                  await controller.player
                                      .seek(Duration.zero, index: index);
                                  controller.currentFileIndex.value =
                                      controller.player.currentIndex!;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        Image.asset(
                                          Assets.icons.microphone.path,
                                        ).image,
                                        color: SolidColors.seeMore,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Obx(
                                          () => Text(
                                            episode.title!,
                                            style: controller.currentFileIndex
                                                        .value ==
                                                    index
                                                ? themeData.textTheme.headline3
                                                : themeData.textTheme.headline4,
                                          ),
                                        ),
                                      ),
                                      Text('${episode.length!}00')
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    ]),
              ),
            ),
            Positioned(
              bottom: 16,
              right: Dimens.bodyMargin,
              left: Dimens.bodyMargin,
              child: Container(
                height: Get.height / 7,
                decoration: MyDecoration.mainGradient,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(
                        () => ProgressBar(
                          timeLabelTextStyle:
                              const TextStyle(color: Colors.white),
                          baseBarColor: Colors.white,
                          thumbColor: Colors.yellow,
                          progressBarColor: Colors.orange,
                          progress: controller.progressValue.value,
                          buffered: controller.bufferedValue.value,
                          total: controller.player.duration ?? Duration.zero,
                          onSeek: (position) {
                            controller.player.seek(position);
                            controller.player.playing
                                ? controller.startProgress()
                                : controller.timer!.cancel();
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await controller.player.seekToNext();
                              controller.currentFileIndex.value =
                                  controller.player.currentIndex!;
                            },
                            child: const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.player.playing
                                  ? controller.timer!.cancel()
                                  : controller.startProgress();
                              controller.player.playing
                                  ? controller.player.pause()
                                  : controller.player.play();
                              controller.startProgress();
                              controller.playState.value =
                                  controller.player.playing;
                              controller.currentFileIndex.value =
                                  controller.player.currentIndex!;
                            },
                            child: Obx(
                              () => Icon(
                                controller.playState.value
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_fill,
                                color: Colors.white,
                                size: 48,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await controller.player.seekToPrevious();
                              controller.currentFileIndex.value =
                                  controller.player.currentIndex!;
                            },
                            child: const Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(),
                          GestureDetector(
                            onTap: () {
                              controller.setLoopMode();
                            },
                            child: Obx(
                              () => Icon(
                                Icons.repeat,
                                color: controller.isLoopAll.value
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
