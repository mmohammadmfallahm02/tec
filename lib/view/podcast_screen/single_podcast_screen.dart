import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
  late SinglePodcastController singlePodcastController;
  late PodcastModel podcastModel;
  SinglePodcast({super.key}) {
    podcastModel = Get.arguments;
    singlePodcastController =
        Get.put(SinglePodcastController(id: podcastModel.id));
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
                                      fit: BoxFit.cover,
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
                            itemCount:
                                singlePodcastController.podcastEpisodes.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              final PodcastFileModel episode =
                                  singlePodcastController
                                      .podcastEpisodes[index];
                              return Padding(
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
                                      child: Text(
                                        episode.title!,
                                        style: themeData.textTheme.headline4,
                                      ),
                                    ),
                                     Text('${episode.length!}00')
                                  ],
                                ),
                              );
                            }),
                      )
                    ]),
              ),
            ),
            Positioned(
              bottom: 8,
              right: Dimens.bodyMargin,
              left: Dimens.bodyMargin,
              child: Container(
                height: Get.height / 7,
                decoration: MyDecoration.mainGradient,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      LinearPercentIndicator(
                        percent: 1.0,
                        backgroundColor: Colors.white,
                        progressColor: Colors.orange,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(
                            Icons.skip_next,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.play_circle_fill,
                            color: Colors.white,
                            size: 48,
                          ),
                          Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                          ),
                          SizedBox(),
                          Icon(
                            Icons.repeat,
                            color: Colors.white,
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
