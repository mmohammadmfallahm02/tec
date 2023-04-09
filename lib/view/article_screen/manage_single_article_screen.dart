import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_color.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article_controller/manage_article_controller.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/services/pick_file.dart';
import 'package:tec/view/article_screen/article_content_editor.dart';
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
  getTitle() {
    Get.defaultDialog(
        backgroundColor: SolidColors.primaryColor,
        titleStyle: const TextStyle(color: SolidColors.scaffoldBg),
        radius: 8,
        title: 'عنوان مقاله',
        content: TextField(
          controller: manageArticleSingleController.titleController,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: SolidColors.seeMore),
          decoration: const InputDecoration(hintText: 'اینجا بنویس'),
        ),
        confirm: ElevatedButton(
            onPressed: () {
              manageArticleSingleController.updateTitle();
              Get.back();
            },
            child: const Text('ثبت')));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    // final Size size = MediaQuery.of(context).size;
    final bodyMargin = Dimens.bodyMargin;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() =>
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                              errorWidget: (context, url, error) => Assets
                                  .images.singlePlaceHolder
                                  .image(fit: BoxFit.cover),
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
                GestureDetector(
                  onTap: () {
                    //get title
                    getTitle();
                  },
                  child: SeeMore(
                    bodyMargin: bodyMargin,
                    themeData: themeData,
                    text: 'ویرایش عنوان مقاله',
                    icon: Assets.icons.bluePen.image(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, bodyMargin * 0.8, 20),
                  child: Text(
                    manageArticleSingleController.articleModel.value.title!,
                    maxLines: 2,
                    style: themeData.textTheme.titleLarge,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ArticleContentEditor());
                  },
                  child: SeeMore(
                    bodyMargin: bodyMargin,
                    themeData: themeData,
                    text: 'ویرایش متن اصلی مقاله',
                    icon: Assets.icons.bluePen.image(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, bodyMargin * 0.8, 20),
                  child: HtmlWidget(
                    manageArticleSingleController.articleModel.value.content!,
                    textStyle: themeData.textTheme.caption,
                    enableCaching: true,
                    onLoadingBuilder: (context, element, loadingProgress) =>
                        const Loading(),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    chooseCatBottomSheet(themeData);
                  },
                  child: SeeMore(
                    bodyMargin: bodyMargin,
                    themeData: themeData,
                    text: 'انتخاب دسته بندی ',
                    icon: Assets.icons.bluePen.image(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, bodyMargin * 0.8, 20),
                  child: HtmlWidget(
                    manageArticleSingleController.articleModel.value.catName ??
                        'هیچ دسته بندی انتخاب نشده',
                    textStyle: themeData.textTheme.caption,
                    enableCaching: true,
                    onLoadingBuilder: (context, element, loadingProgress) =>
                        const Loading(),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await manageArticleSingleController.storeArticle();
                    },
                    child: Text(manageArticleSingleController.loading.value
                        ? 'صبر کنید...'
                        : 'ارسال مطلب'))
              ])),
        ),
      ),
    );
  }

  Widget cats(ThemeData themeData) {
    var homeScreenController = Get.find<HomeScreenController>();
    return SizedBox(
      height: Get.height / 1.7,
      child: GridView.builder(
        itemCount: homeScreenController.tagsList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          final tag = homeScreenController.tagsList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                manageArticleSingleController.articleModel.update((val) {
                  val?.catId = tag.id;
                  val?.catName = tag.title;
                });

                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: SolidColors.primaryColor,
                    borderRadius: BorderRadius.circular(18)),
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Center(
                    child: Text(
                      tag.title!,
                      style: themeData.textTheme.headline2,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 5, mainAxisSpacing: 5),
      ),
    );
  }

  chooseCatBottomSheet(ThemeData themeData) {
    Get.bottomSheet(
        Container(
          height: Get.height / 1.5,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              const Text('انتخاب دسته بندی'),
              const SizedBox(
                height: 8,
              ),
              cats(themeData)
            ]),
          ),
        ),
        isScrollControlled: true,
        persistent: true);
  }
}
