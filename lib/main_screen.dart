import 'package:flutter/material.dart';
import 'package:tec/constants/my_color.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/models/fake_data.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double bodyMargin = size.width / 16;
    final ThemeData themeData = Theme.of(context);
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          // appbar
          Padding(
            padding: EdgeInsets.fromLTRB(bodyMargin, 16, bodyMargin, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ImageIcon(
                  Assets.icons.menu.image().image,
                  size: 26,
                ),
                Assets.images.logo.image(height: size.height / 13.6),
                ImageIcon(Assets.icons.search.image().image, size: 30)
              ],
            ),
          ),
          // poster
          Stack(
            children: [
              Container(
                width: size.width / 1.14,
                height: size.height / 4.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(homePagePosterMap['ImageAssets'])),
                ),
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: const LinearGradient(
                    colors: GradiantColors.homePosterCoverGradiant,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                  left: 24,
                  right: 24,
                  bottom: 16,
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${homePagePosterMap["writer"]}  -  ${homePagePosterMap["date"]}",
                              style: themeData.textTheme.subtitle1,
                            ),
                            Row(
                              children: [
                                Text(homePagePosterMap["view"],
                                    style: themeData.textTheme.subtitle1),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Icon(
                                  Icons.remove_red_eye_sharp,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            )
                          ]),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        homePagePosterMap["title"],
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: themeData.textTheme.headline1,
                      )
                    ],
                  ))
            ],
          ),
          const SizedBox(
            height: 46,
          ),
          // tag list
          SizedBox(
            height: 55,
            child: ListView.builder(
                itemCount: tagList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final tag = tagList[index];
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                       8, 8, index == 0 ? bodyMargin : 8, 8),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: GradiantColors.tags,
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft),
                          borderRadius: BorderRadius.circular(16)),
                      height: 55,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24, 8, 16, 8),
                        child: Row(
                          children: [
                            ImageIcon(
                              Assets.icons.hashtag.image().image,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              tag.title,
                              style: themeData.textTheme.headline2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    ));
  }
}
