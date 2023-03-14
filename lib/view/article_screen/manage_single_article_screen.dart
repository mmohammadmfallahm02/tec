import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tec/component/my_color.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article_controller/list_article_controller.dart';
import 'package:tec/controller/article_controller/manage_article_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/view/article_screen/article_list_screen.dart';

class ManageArticleSingleScreen extends StatefulWidget {
  const ManageArticleSingleScreen({
    super.key,
  });

  @override
  State<ManageArticleSingleScreen> createState() =>
      _ManageArticleSingleScreenState();
}

class _ManageArticleSingleScreenState extends State<ManageArticleSingleScreen> {
  var manageArticleSingleController = Get.find<ManageArticleController>();
  // SingleArticleController singleArticleController =
  //     Get.put(SingleArticleController());
  // @override
  // void initState() {
  //   super.initState();
  //   singleArticleController.getArticleInfo();
  // }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() =>
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                        imageUrl: manageArticleSingleController
                            .articleModel.value.image!,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              const Icon(
                                Icons.bookmark_outline,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await Share.share(
                                      manageArticleSingleController
                                          .articleModel.value.title!);
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
                    Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                            child: Container(
                          height: 30,
                          width: 60,
                          color: SolidColors.primaryColor,
                        ))),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    manageArticleSingleController.articleModel.value.title!,
                    maxLines: 2,
                    style: themeData.textTheme.titleLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: HtmlWidget(
                    manageArticleSingleController.articleModel.value.content!,
                    textStyle: themeData.textTheme.caption,
                    enableCaching: true,
                    onLoadingBuilder: (context, element, loadingProgress) =>
                        const Loading(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: SizedBox(
                    height: 55,
                    child: ListView.builder(
                        itemCount: manageArticleSingleController.tagList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final tag =
                              manageArticleSingleController.tagList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () async {
                                await Get.find<ListArticleController>()
                                    .getArticleListWithTagId(
                                  tag.id!,
                                );
                                Get.to(ArticleListScreen(title: tag.title!));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: SolidColors.surfaceColor,
                                    borderRadius: BorderRadius.circular(18)),
                                height: 55,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 16, left: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        tag.title!,
                                        style: themeData.textTheme.headline4,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                const SizedBox(
                  height: 32,
                )
              ])),
        ),
      ),
    );
  }
}
