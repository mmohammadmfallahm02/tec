import 'package:get/get.dart';
import 'package:tec/controller/article_controller/list_article_controller.dart';
import 'package:tec/controller/article_controller/manage_article_controller.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/controller/article_controller/single_article_controller.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ListArticleController());
    Get.lazyPut(() => SingleArticleController());
  }
}

class ManageArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageArticleController());
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}
