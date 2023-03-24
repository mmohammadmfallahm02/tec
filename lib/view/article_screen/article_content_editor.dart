import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/controller/article_controller/manage_article_controller.dart';
import 'package:tec/view/article_screen/manage_article.dart';

class ArticleContentEditor extends StatefulWidget {
  const ArticleContentEditor({super.key});

  @override
  State<ArticleContentEditor> createState() => _ArticleContentEditorState();
}

class _ArticleContentEditorState extends State<ArticleContentEditor> {
  final HtmlEditorController controller = HtmlEditorController();
  var manageArticleSingleController = Get.put(ManageArticleController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.clearFocus();
      },
      child: Scaffold(
        appBar: appBar('نوشتن/ویرایش مقاله'),
        body: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HtmlEditor(
              controller: controller,
              htmlEditorOptions: HtmlEditorOptions(
                  hint: 'میتونی مقاله خودتو اینجا بنویسی',
                  shouldEnsureVisible: true,
                  initialText: manageArticleSingleController
                      .articleModel.value.content!),
              callbacks: Callbacks(
                onChangeContent: (p0) =>
                    manageArticleSingleController.articleModel.update((val) {
                  val?.content = p0;
                }),
              ),
            )
          ],
        )),
      ),
    );
  }
}
