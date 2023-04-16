import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/my_color.dart';
import 'package:tec/my_http_overrides.dart';
import 'package:tec/binding.dart';
import 'package:tec/view/article_screen/article_single_screen.dart';
import 'package:tec/view/article_screen/manage_article.dart';
import 'package:tec/view/article_screen/manage_single_article_screen.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/podcast_screen/single_podcast_screen.dart';
import 'package:tec/view/splash_screen.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark));
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final ThemeData themeData = Theme.of(context);
    return GetMaterialApp(
        initialBinding: RegisterBinding(),
        debugShowCheckedModeBanner: false,
        locale: const Locale('fa'),
        title: 'Flutter Demo',
        getPages: [
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
            page: () =>  SinglePodcast(),
          )
        ],
        theme: lightTheme(),
        home: const SplashScreen());
  }

  ThemeData lightTheme() {
    return ThemeData(
        inputDecorationTheme: InputDecorationTheme(
            hintStyle: const TextStyle(
              color: SolidColors.hintColor,
              fontWeight: FontWeight.w700,
              fontFamily: 'dana',
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(width: 2),
            ),
            filled: true,
            fillColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return const TextStyle(
                  fontFamily: 'dana',
                  fontSize: 18,
                  color: SolidColors.posterTitle,
                  fontWeight: FontWeight.w700,
                );
              }
              return const TextStyle(
                fontFamily: 'dana',
                fontSize: 14,
                color: SolidColors.posterSubTitle,
                fontWeight: FontWeight.w700,
              );
            }),
            backgroundColor: MaterialStateProperty.resolveWith(
              (states) {
                if (states.contains(MaterialState.pressed)) {
                  return SolidColors.seeMore;
                }
                return SolidColors.primaryColor;
              },
            ),
          ),
        ),
        primarySwatch: Colors.blue,
        fontFamily: 'dana',
        brightness: Brightness.light,
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: 'dana',
            fontSize: 18,
            color: SolidColors.posterTitle,
            fontWeight: FontWeight.w700,
          ),
          subtitle1: TextStyle(
            fontFamily: 'dana',
            fontSize: 14,
            color: SolidColors.posterSubTitle,
            fontWeight: FontWeight.w300,
          ),
          headline2: TextStyle(
              fontFamily: 'dana',
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w300),
          headline3: TextStyle(
              fontFamily: 'dana',
              fontSize: 14,
              color: SolidColors.seeMore,
              fontWeight: FontWeight.w700),
          bodyText1: TextStyle(
              fontFamily: 'dana', fontSize: 13, fontWeight: FontWeight.w300),
          headline4: TextStyle(
              fontFamily: 'dana',
              fontSize: 14,
              color: Color.fromARGB(255, 70, 70, 70),
              fontWeight: FontWeight.w700),
        ));
  }
}

class NamedRoute {
  NamedRoute._();
  static String routeMainScreen = '/MainScreen';
  static String routeArticleSingleScreen = '/ArticleSingleScreen';
  static String routeManageArticleScreen = '/ManageArticle';
  static String routeManageArticleSingleScreen = '/ManageArticleSingle';
  static String routeSinglePodcastScreen = '/SinglePodcast';
}
