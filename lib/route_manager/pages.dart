import 'package:get/get.dart';
import 'package:tec/route_manager/binding.dart';
import 'package:tec/route_manager/names.dart';
import 'package:tec/view/article_screen/article_single_screen.dart';
import 'package:tec/view/article_screen/manage_article.dart';
import 'package:tec/view/article_screen/manage_single_article_screen.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/podcast_screen/single_podcast_screen.dart';
import 'package:tec/view/splash_screen.dart';

class Pages {
  Pages._();
  static List<GetPage<dynamic>> pages = [
    GetPage(
        name: NamedRoute.initialRoute,
        page: () => const SplashScreen(),
        binding: RegisterBinding()),
    GetPage(
        name: NamedRoute.routeMainScreen,
        page: () => MainScreen(),
        binding: RegisterBinding()),
    GetPage(
        name: NamedRoute.routeArticleSingleScreen,
        page: () => const ArticleSingleScreen(),
        binding: ArticleBinding()),
    GetPage(
        name: NamedRoute.routeManageArticleScreen,
        page: () => ManageArticle(),
        binding: ManageArticleBinding()),
    GetPage(
        name: NamedRoute.routeManageArticleSingleScreen,
        page: () => const ManageArticleSingleScreen(),
        binding: ManageArticleBinding()),
    GetPage(
      name: NamedRoute.routeSinglePodcastScreen,
      page: () => SinglePodcast(),
    )
  ];
}
