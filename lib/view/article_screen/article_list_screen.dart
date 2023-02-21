import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/list_article_controller.dart';
import 'package:tec/controller/single_article_controller.dart';
import 'package:tec/view/article_screen/article_single_screen.dart';

class ArticleListScreen extends StatelessWidget {
  final String title;
  ArticleListScreen({super.key, required this.title});
  ListArticleController listArticleController =
      Get.put(ListArticleController());
  SingleArticleController singleArticleController =
      Get.put(SingleArticleController());
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: appbar(title),
      body: SafeArea(
          child: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: ListView.builder(
                itemCount: listArticleController.articleList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final article = listArticleController.articleList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        singleArticleController.id.value =
                            int.parse(article.id!);
                        Get.to(
                          const ArticleSingleScreen(),
                        );
                      },
                      child: SizedBox(
                        height: 120,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: article.image!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover)),
                              ),
                              placeholder: (context, url) => const Loading(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.image_not_supported_outlined,
                                size: 50,
                                color: Colors.grey,
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
                                        style: themeData.textTheme.caption,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        'بازدید ${article.view!}',
                                        style: themeData.textTheme.caption,
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
        ),
      )),
    );
  }
}
