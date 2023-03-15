import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/article_controller/manage_article_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/main.dart';
// import 'package:validators/validators.dart';

// ignore: must_be_immutable
class ManageArticle extends StatelessWidget {
  ManageArticle({super.key});

  var manageArticleController = Get.find<ManageArticleController>();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () {},
          label: SizedBox(
            height: 45,
            width: size.width * 0.75,
            child: ElevatedButton(
              clipBehavior: Clip.none,
              onPressed: () {
                Get.toNamed(NamedRoute.routeManageArticleSingleScreen);
              },
              child: const Text(
                'بریم برای نوشتن یه مقاله باحال',
                maxLines: 1,
              ),
            ),
          )),
      appBar: appBar('مدیریت مقاله ها'),
      body: SafeArea(
          child: Center(
              child: Obx(
        () => manageArticleController.loading.isTrue
            ? const Loading()
            : manageArticleController.articleList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: ListView.builder(
                          itemCount: manageArticleController.articleList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final article =
                                manageArticleController.articleList[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () {
                                  //TODO  route to single article screen
                                },
                                child: SizedBox(
                                  height: 120,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: article.image!,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          height: 120,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        ),
                                        placeholder: (context, url) =>
                                            const Loading(),
                                        errorWidget: (context, url, error) =>
                                            const SizedBox(
                                          height: 120,
                                          width: 120,
                                          child: Icon(
                                            Icons.image_not_supported_outlined,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(article.title!),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  article.author!,
                                                  style: themeData
                                                      .textTheme.caption,
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Text(
                                                  'بازدید ${article.view!}',
                                                  style: themeData
                                                      .textTheme.caption,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  )
                : articleEmptyState(themeData, size),
      ))),
    );
  }

  Column articleEmptyState(ThemeData themeData, Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.images.emptyState.image(height: 100),
        const SizedBox(
          height: 24,
        ),
        RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                text: MyStrings.articleEmpty,
                style: themeData.textTheme.headline4)),
      ],
    );
  }
}
