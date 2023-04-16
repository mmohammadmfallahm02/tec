import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tec/component/decorations.dart';
import 'package:tec/component/dimens.dart';
import '../../component/my_component.dart';
import '../../constant/my_color.dart';
import '../../gen/assets.gen.dart';

class SinglePodcast extends StatelessWidget {
  const SinglePodcast({super.key});

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
                          CachedNetworkImage(
                              imageUrl:
                                  'https://static.digiato.com/digiato/2023/04/a8124d0d2a0602a2f4bf9159325a455a1a09fd24-910x600.jpg',
                              imageBuilder: (context, imageProvider) =>
                                  Image(image: imageProvider),
                              placeholder: (context, url) => const Loading(),
                              errorWidget: (context, url, error) =>
                                  Assets.images.singlePlaceHolder.image()),
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
                          'عنوان پادکست',
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
                              'ساسان صفری',
                              style: themeData.textTheme.headline4,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
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
                                      'بخش چهارم: فریلنسر دیوانه',
                                      style: themeData.textTheme.headline4,
                                    ),
                                  ),
                                  const Text('22:00')
                                ],
                              ),
                            );
                          })
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
