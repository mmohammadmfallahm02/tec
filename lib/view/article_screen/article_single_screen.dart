import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_color.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/list_article_controller.dart';
import 'package:tec/controller/single_article_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/view/article_screen/article_list_screen.dart';

class ArticleSingleScreen extends StatefulWidget {
  const ArticleSingleScreen({
    super.key,
  });

  @override
  State<ArticleSingleScreen> createState() => _ArticleSingleScreenState();
}

class _ArticleSingleScreenState extends State<ArticleSingleScreen> {
  SingleArticleController singleArticleController =
      Get.put(SingleArticleController());
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
          child: Obx(
            () => singleArticleController.loading.value == false
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Stack(
                          children: [
                            CachedNetworkImage(
                                imageUrl: singleArticleController
                                    .articleInfoModel.value.image!,
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
                                          colors: GradiantColors
                                              .articleSingleAppbarGradiant,
                                          end: Alignment.bottomCenter,
                                          begin: Alignment.topCenter)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                      Expanded(child: SizedBox()),
                                      Icon(
                                        Icons.bookmark_outline,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
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
                            singleArticleController
                                .articleInfoModel.value.title!,
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
                                singleArticleController
                                    .articleInfoModel.value.author!,
                                style: themeData.textTheme.headline4,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(
                                singleArticleController
                                    .articleInfoModel.value.createdAt!,
                                style: themeData.textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: HtmlWidget(
                            singleArticleController
                                .articleInfoModel.value.content!,
                            textStyle: themeData.textTheme.caption,
                            enableCaching: true,
                            onLoadingBuilder:
                                (context, element, loadingProgress) =>
                                    const Loading(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: SizedBox(
                            height: 55,
                            child: ListView.builder(
                                itemCount:
                                    singleArticleController.tagsList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final tag =
                                      singleArticleController.tagsList[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        await Get.find<ListArticleController>()
                                            .getArticleListWithTagId(
                                          tag.id!,
                                        );
                                        Get.to(ArticleListScreen(
                                            title: tag.title!));
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: SolidColors.surfaceColor,
                                            borderRadius:
                                                BorderRadius.circular(18)),
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
                                                style: themeData
                                                    .textTheme.headline4,
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
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16, top: 16, bottom: 20),
                          child: Text('نوشته های مرتبط',
                              style: themeData.textTheme.headline3),
                        ),
                        topVisitedList(themeData, size),
                        const SizedBox(
                          height: 32,
                        )
                      ])
                : SizedBox(height: Get.height, child: const Loading()),
          ),
        ),
      ),
    );
  }

  Widget topVisitedList(ThemeData themeData, Size size) {
    return SizedBox(
      height: size.height / 4.1,
      child: ListView.builder(
          itemCount: singleArticleController.relatedArticle.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final article = singleArticleController.relatedArticle[index];
            // blog item
            return Padding(
              padding: EdgeInsets.fromLTRB(4, 8, index == 0 ? 25 : 16, 8),
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
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover)),
                                    foregroundDecoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                            colors:
                                                GradiantColors.blogPostGradint,
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                  ),
                              placeholder: (context, url) => const Loading(),
                              errorWidget: (context, url, error) => const Icon(
                                    Icons.image_not_supported_outlined,
                                    color: Colors.grey,
                                    size: 30,
                                  )),
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
                                          style: themeData.textTheme.subtitle1),
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
    );
  }
}
