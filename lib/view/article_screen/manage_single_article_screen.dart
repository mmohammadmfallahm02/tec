import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_color.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article_controller/list_article_controller.dart';
import 'package:tec/controller/article_controller/manage_article_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/services/pick_file.dart';
import 'package:tec/view/article_screen/article_list_screen.dart';

import '../../controller/file_controller.dart';

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
  FilePickerController filePickerController = Get.put(FilePickerController());

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    // final Size size = MediaQuery.of(context).size;
    final bodyMargin = Dimens.bodyMargin;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() =>
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Stack(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: Get.height / 3,
                      child: filePickerController.file.value.name == 'nothing'
                          ? CachedNetworkImage(
                              imageUrl: manageArticleSingleController
                                  .articleModel.value.image!,
                              imageBuilder: (context, imageProvider) =>
                                  Image(image: imageProvider),
                              placeholder: (context, url) => const Loading(),
                              errorWidget: (context, url, error) =>
                                  Assets.images.singlePlaceHolder.image(),
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(
                                filePickerController.file.value.path!,
                              ),
                              fit: BoxFit.cover,
                            ),
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
                            ],
                          ),
                        )),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                            child: GestureDetector(
                          onTap: () {
                            pickFile();
                          },
                          child: Container(
                            height: 30,
                            width: Get.size.width / 3,
                            decoration: const BoxDecoration(
                                color: SolidColors.primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'انتخاب تصویر',
                                    style: themeData.textTheme.headline2,
                                  ),
                                  const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 16,
                                  )
                                ]),
                          ),
                        ))),
                  ],
                ),
                SeeMore(
                  bodyMargin: bodyMargin,
                  themeData: themeData,
                  text: 'ویرایش عنوان مقاله',
                  icon: Assets.icons.bluePen.image(),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, bodyMargin, 20),
                  child: Text(
                    manageArticleSingleController.articleModel.value.title!,
                    maxLines: 2,
                    style: themeData.textTheme.titleLarge,
                  ),
                ),
                SeeMore(
                  bodyMargin: bodyMargin,
                  themeData: themeData,
                  text: 'ویرایش متن اصلی مقاله',
                  icon: Assets.icons.bluePen.image(),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, bodyMargin, 20),
                  child: HtmlWidget(
                    manageArticleSingleController.articleModel.value.content!,
                    textStyle: themeData.textTheme.caption,
                    enableCaching: true,
                    onLoadingBuilder: (context, element, loadingProgress) =>
                        const Loading(),
                  ),
                ),
                SeeMore(
                  bodyMargin: bodyMargin,
                  themeData: themeData,
                  text: 'انتخاب دسته بندی ',
                  icon: Assets.icons.bluePen.image(),
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
