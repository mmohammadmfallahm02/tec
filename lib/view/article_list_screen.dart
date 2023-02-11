import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article_controller.dart';

class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({super.key});
  ArticleController articleController = Get.put(ArticleController());
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: appbar('مقالات جدید'),
      body: SafeArea(
          child: Obx(
        () => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: ListView.builder(
                itemCount: articleController.articleList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final article = articleController.articleList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: article.image!,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover)),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(article.title!),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                  );
                }),
          ),
        ),
      )),
    );
  }
}
