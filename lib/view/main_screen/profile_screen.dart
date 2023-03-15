import 'package:flutter/material.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_color.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/gen/assets.gen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
    required this.size,
    required this.themeData,
    required this.bodyMargin,
  }) : super(key: key);

  final Size size;
  final ThemeData themeData;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 48),
        child: Column(children: [
          Assets.images.profileAvatar.image(height: 100),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                Assets.icons.bluePen.image().image,
                color: SolidColors.seeMore,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                MyStrings.editProfileImage,
                style: themeData.textTheme.headline3,
              ),
            ],
          ),
          const SizedBox(
            height: 64,
          ),
          Text(
            'فاطمه امیری',
            style: themeData.textTheme.headline4!
                .apply(color: SolidColors.primaryColor),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'fatemeamiri@gmail.com',
            style: themeData.textTheme.headline4,
          ),
          const SizedBox(
            height: 48,
          ),
          TechDivider(size: size),
          InkWell(
            splashColor: SolidColors.primaryColor,
            onTap: () {},
            child: SizedBox(
              height: 45,
              child: Center(
                child: Text(
                  MyStrings.myFavoriteBlog,
                  style: themeData.textTheme.headline4,
                ),
              ),
            ),
          ),
          TechDivider(size: size),
          InkWell(
              splashColor: SolidColors.primaryColor,
              onTap: () {},
              child: SizedBox(
                height: 45,
                child: Center(
                  child: Text(MyStrings.myFavoritePodcast,
                      style: themeData.textTheme.headline4),
                ),
              )),
          TechDivider(size: size),
          InkWell(
              splashColor: SolidColors.primaryColor,
              onTap: () {},
              child: SizedBox(
                  height: 45,
                  child: Center(
                      child: Text(MyStrings.logOut,
                          style: themeData.textTheme.headline4)))),
        ]),
      ),
    );
  }
}
