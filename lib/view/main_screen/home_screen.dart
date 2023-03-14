import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/component/my_color.dart';
import 'package:tec/component/my_strings.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/controller/article_controller/list_article_controller.dart';
import 'package:tec/controller/article_controller/single_article_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/view/article_screen/article_list_screen.dart';

import '../../models/fake_data.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
    required this.size,
    required this.themeData,
    required this.bodyMargin,
  }) : super(key: key);

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  SingleArticleController singleArticleController =
      Get.put(SingleArticleController());
  ListArticleController listArticleController =
      Get.put(ListArticleController());
  final Size size;
  final ThemeData themeData;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: SingleChildScrollView(
            child: homeScreenController.loading.value == false
                ? Column(
                    children: [
                      const SizedBox(
                        height: 26,
                      ),
                      homePagePoster(),
                      const SizedBox(
                        height: 32,
                      ),
                      tagsList(),
                      // see more
                      GestureDetector(
                        onTap: () {
                          Get.to(ArticleListScreen(title: 'مقلات جدید'));
                        },
                        child: SeeMore(
                          bodyMargin: bodyMargin,
                          themeData: themeData,
                          text: MyStrings.viewHottestBlog,
                          icon: Assets.icons.bluePen.image(),
                        ),
                      ),
                      topVisitedList(),
                      SeeMore(
                          bodyMargin: bodyMargin,
                          themeData: themeData,
                          text: MyStrings.viewHottestPodCasts,
                          icon: Assets.icons.microphone.image()),
                      topPodcastList(),
                      const SizedBox(
                        height: 60,
                      )
                    ],
                  )
                : const Loading()),
      ),
    );
  }

  Widget topVisitedList() {
    return SizedBox(
      height: size.height / 4.1,
      child: Obx(
        () => ListView.builder(
            itemCount: homeScreenController.topVisitedList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final article = homeScreenController.topVisitedList[index];
              // blog item
              return Padding(
                padding:
                    EdgeInsets.fromLTRB(4, 8, index == 0 ? bodyMargin : 16, 8),
                child: GestureDetector(
                  onTap: () {
                    singleArticleController
                        .getArticleInfo(int.parse(article.id!));
                  },
                  child: Column(
                    children: [
                      // blog post image
                      SizedBox(
                        height: size.height / 5.9,
                        width: size.width / 2.6,
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                                imageUrl: article.image!,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover)),
                                      foregroundDecoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              colors: GradientColors
                                                  .blogPostGradient,
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                    ),
                                placeholder: (context, url) => const Loading(),
                                errorWidget: (context, url, error) =>
                                    myErrorImageWidget()),
                            Positioned(
                                bottom: 8,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(article.author!,
                                        style: themeData.textTheme.subtitle1),
                                    Row(
                                      children: [
                                        Text(article.view!,
                                            style:
                                                themeData.textTheme.subtitle1),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Icon(
                                          Icons.remove_red_eye_sharp,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      // blog post text
                      Expanded(
                        child: SizedBox(
                            width: size.width / 2.6,
                            child: Text(
                              article.title!,
                              maxLines: 2,
                              softWrap: true,
                              // textAlign: TextAlign.justify,
                              overflow: TextOverflow.fade,
                            )),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget topPodcastList() {
    return SizedBox(
      height: size.height / 4.5,
      child: Obx(
        () => ListView.builder(
            itemCount: homeScreenController.topPodcasts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final podcast = homeScreenController.topPodcasts[index];
              return Padding(
                padding:
                    EdgeInsets.fromLTRB(4, 8, index == 0 ? bodyMargin : 16, 8),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 6.5,
                      width: size.width / 3.2,
                      child: CachedNetworkImage(
                        imageUrl: podcast.poster!,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        ),
                        placeholder: (context, url) => const Loading(),
                        errorWidget: (context, url, error) =>
                            myErrorImageWidget(),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(podcast.title!)
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget myErrorImageWidget() {
    return const Center(
      child: Icon(
        Icons.image_not_supported_outlined,
        size: 45,
        color: Colors.grey,
      ),
    );
  }

  Widget homePagePoster() {
    return Stack(
      children: [
        SizedBox(
          width: size.width / 1.14,
          height: size.height / 4.3,
          child: CachedNetworkImage(
            imageUrl: homeScreenController.poster.value.image!,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: const LinearGradient(
                  colors: GradientColors.homePosterCoverGradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            placeholder: (context, url) => const Loading(),
            errorWidget: (context, url, error) => myErrorImageWidget(),
          ),
        ),
        Positioned(
            left: 24,
            right: 24,
            bottom: 16,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${homePagePosterMap["writer"]}  -  ${homePagePosterMap["date"]}",
                        style: themeData.textTheme.subtitle1,
                      ),
                      Row(
                        children: [
                          Text('251', style: themeData.textTheme.subtitle1),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.remove_red_eye_sharp,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      )
                    ]),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  homeScreenController.poster.value.title!,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: themeData.textTheme.headline1,
                )
              ],
            ))
      ],
    );
  }

  Widget tagsList() {
    return SizedBox(
      height: 70,
      child: ListView.builder(
          itemCount: homeScreenController.tagsList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final tag = homeScreenController.tagsList[index];
            return Padding(
              padding:
                  EdgeInsets.fromLTRB(8, 17, index == 0 ? bodyMargin : 8, 17),
              child: GestureDetector(
                onTap: () {
                  listArticleController.getArticleListWithTagId(tag.id!);
                  Get.to(ArticleListScreen(title: tag.title!));
                },
                child: MainTags(
                  index: index,
                  themeData: themeData,
                  isCategoryList: false,
                ),
              ),
            );
          }),
    );
  }
}

class SeeMore extends StatelessWidget {
  const SeeMore({
    Key? key,
    required this.bodyMargin,
    required this.themeData,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final double bodyMargin;
  final ThemeData themeData;
  final String text;
  final Image icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, top: 25, bottom: 8),
      child: Row(
        children: [
          ImageIcon(
            icon.image,
            color: SolidColors.seeMore,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(text, style: themeData.textTheme.headline3),
        ],
      ),
    );
  }
}
