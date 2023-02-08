import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tec/component/my_color.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/models/data_models.dart';
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
    required this.tag,
    required this.themeData,
    required this.isCategoryList,
  }) : super(key: key);

  final HashTagModel tag;
  final ThemeData themeData;
  final bool isCategoryList;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: GradiantColors.tags,
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
              tag.title,
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