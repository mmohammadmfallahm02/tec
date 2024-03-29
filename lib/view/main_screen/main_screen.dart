// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tec/component/decorations.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_color.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/view/main_screen/home_screen.dart';
import 'package:tec/view/main_screen/profile_screen.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  RxInt selectedPageIndex = 0.obs;

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bodyMargin = Dimens.bodyMargin;
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      key: _key,
      drawer: Drawer(
        backgroundColor: SolidColors.scaffoldBg,
        child: ListView(
            padding: EdgeInsets.only(left: bodyMargin, right: bodyMargin),
            children: [
              DrawerHeader(
                  child: Center(
                child: Assets.images.logo.image(scale: 3),
              )),
              const Divider(
                color: SolidColors.dividerColor,
                height: 10,
                thickness: 1,
              ),
              ListTile(
                title: Text(
                  'پروفایل کاربری',
                  style: themeData.textTheme.headline4,
                ),
              ),
              const Divider(
                color: SolidColors.dividerColor,
                height: 10,
                thickness: 1,
              ),
              ListTile(
                title: Text('درباره تک‌بلاگ',
                    style: themeData.textTheme.headline4),
              ),
              const Divider(
                color: SolidColors.dividerColor,
                height: 10,
                thickness: 1,
              ),
              ListTile(
                onTap: () async {
                  await Share.share(MyStrings.shareText);
                },
                title: Text('اشتراک گذاری تک بلاگ',
                    style: themeData.textTheme.headline4),
              ),
              const Divider(
                color: SolidColors.dividerColor,
                height: 10,
                thickness: 1,
              ),
              ListTile(
                onTap: () {
                  myLaunchUrl(MyStrings.techBlogGithubUrl);
                },
                title: Text('تک‌بلاگ در گیت هاب',
                    style: themeData.textTheme.headline4),
              ),
            ]),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: SolidColors.scaffoldBg,
        elevation: 0,
        title: _appBar(bodyMargin, size),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Obx(
            () {
              return IndexedStack(
                index: selectedPageIndex.value,
                children: [
                  HomeScreen(
                      size: size, themeData: themeData, bodyMargin: bodyMargin),
                  const Text('second screen1'),
                  ProfileScreen(
                      size: size, themeData: themeData, bodyMargin: bodyMargin),
                ],
              );
            },
          )),
          BottomNavigation(
            size: size,
            bodyMargin: bodyMargin,
            changeScreen: (int currentPageIndex) {
              selectedPageIndex.value = currentPageIndex;
            },
          )
        ],
      ),
    ));
  }

  Widget _appBar(double bodyMargin, Size size) {
    return Padding(
      padding: EdgeInsets.fromLTRB(bodyMargin * 0.6, 16, bodyMargin * 0.6, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _key.currentState!.openDrawer();
            },
            child: ImageIcon(
              Assets.icons.menu.image().image,
              size: 26,
              color: Colors.black,
            ),
          ),
          Assets.images.logo.image(height: size.height / 13.6),
          ImageIcon(
            Assets.icons.search.image().image,
            size: 30,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
    required this.size,
    required this.bodyMargin,
    required this.changeScreen,
  }) : super(key: key);

  final Size size;
  final double bodyMargin;
  final Function(int) changeScreen;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        height: size.height / 10,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: GradientColors.bottomNavBackground,
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(bodyMargin * 1.5, 10, bodyMargin * 1.5, 10),
          child: Container(
            height: size.height / 8,
            decoration: MyDecoration.mainGradient,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                      onPressed: () => changeScreen(0),
                      icon: Assets.icons.home.image()),
                  IconButton(
                      onPressed: () {
                        // changeScreen(1);
                        //TODO check login status
                        Get.find<RegisterController>().toggleLogin();
                      },
                      icon: Assets.icons.write.image()),
                  IconButton(
                      onPressed: () => changeScreen(2),
                      icon: Assets.icons.user.image()),
                ]),
          ),
        ),
      ),
    );
  }
}
