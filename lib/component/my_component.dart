// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tec/constant/my_color.dart';
import 'package:tec/component/text_style.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class TechDivider extends StatelessWidget {
  const TechDivider({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: SolidColors.dividerColor,
      indent: size.width / 6,
      endIndent: size.width / 6,
    );
  }
}

class MainTags extends StatelessWidget {
  const MainTags({
    Key? key,
    required this.index,
    required this.themeData,
    required this.isCategoryList,
  }) : super(key: key);

  final int index;
  final ThemeData themeData;
  final bool isCategoryList;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: GradientColors.tags,
              begin: Alignment.centerRight,
              end: Alignment.centerLeft),
          borderRadius: BorderRadius.circular(18)),
      height: 55,
      child: Padding(
        padding: isCategoryList
            ? const EdgeInsets.only(right: 8)
            : const EdgeInsets.fromLTRB(24, 8, 16, 8),
        child: Row(
          children: [
            ImageIcon(
              Assets.icons.hashtag.image().image,
              color: Colors.white,
              size: 16,
            ),
            isCategoryList
                ? const SizedBox(
                    width: 4,
                  )
                : const SizedBox(
                    width: 16,
                  ),
            Text(
              Get.find<HomeScreenController>().tagsList[index].title!,
              style: themeData.textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}

myLaunchUrl(String url) async {
  var uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    log("could not launch ${uri.toString()}");
  }
}

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitFadingCube(
      color: SolidColors.primaryColor,
      size: 32,
    );
  }
}

PreferredSize appBar(String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: Padding(
      padding: const EdgeInsets.only(right: 16, left: 16),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Center(
            child: Text(
              title,
              style: appBarTextStyle,
            ),
          )
        ],
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SolidColors.primaryColor.withAlpha(100)),
            child: const Icon(
              Icons.keyboard_arrow_right,
              size: 40,
            ),
          ),
        ),
      ),
    ),
  );
}
class SeeMore extends StatelessWidget {
  const SeeMore({
    Key? key,
    required this.bodyMargin,
    required this.themeData,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final double bodyMargin;
  final ThemeData themeData;
  final String text;
  final Image icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, top: 25, bottom: 8),
      child: Row(
        children: [
          ImageIcon(
            icon.image,
            color: SolidColors.seeMore,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(text, style: themeData.textTheme.headline3),
        ],
      ),
    );
  }
}
