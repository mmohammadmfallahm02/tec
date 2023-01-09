import 'package:flutter/material.dart';
import 'package:tec/constants/my_color.dart';
import 'package:tec/constants/my_strings.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/models/fake_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
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
      child: Column(
        children: [
          const SizedBox(
            height: 26,
          ),
          HomePagePoster(size: size, themeData: themeData),
          const SizedBox(
            height: 32,
          ),
          HomePageTagList(bodyMargin: bodyMargin, themeData: themeData),
          // see more
          SeeMore(
            bodyMargin: bodyMargin,
            themeData: themeData,
            text: MyStrings.viewHotestBlog,
            icon: Assets.icons.bluePen.image(),
          ),
          HomePageBlogList(
              size: size, bodyMargin: bodyMargin, themeData: themeData),
          SeeMore(
              bodyMargin: bodyMargin,
              themeData: themeData,
              text: MyStrings.viewHotestPodCasts,
              icon: Assets.icons.microphone.image()),
          HomePagePodcastList(size: size, bodyMargin: bodyMargin),
          const SizedBox(
            height: 60,
          )
        ],
      ),
    );
  }
}

class HomePagePodcastList extends StatelessWidget {
  const HomePagePodcastList({
    Key? key,
    required this.size,
    required this.bodyMargin,
  }) : super(key: key);

  final Size size;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 4.5,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.fromLTRB(
                  4, 8, index == 0 ? bodyMargin : 16, 8),
              child: Column(
                children: [
                  Container(
                    height: size.height / 6.5,
                    width: size.width / 3.2,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(18)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text('podcast $index')
                ],
              ),
            );
          }),
    );
  }
}

class HomePageBlogList extends StatelessWidget {
  const HomePageBlogList({
    Key? key,
    required this.size,
    required this.bodyMargin,
    required this.themeData,
  }) : super(key: key);

  final Size size;
  final double bodyMargin;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 4.1,
      child: ListView.builder(
          itemCount: blogList.getRange(0, 5).length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final blog = blogList[index];
            // blog item
            return Padding(
              padding: EdgeInsets.fromLTRB(
                  4, 8, index == 0 ? bodyMargin : 16, 8),
              child: Column(
                children: [
                  // blog post image
                  SizedBox(
                    height: size.height / 5.9,
                    width: size.width / 2.6,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                                image: NetworkImage(
                                  blog.imageUrl,
                                ),
                                fit: BoxFit.cover),
                          ),
                          foregroundDecoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: GradiantColors.blogPostGradint,
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                              children: [
                                Text(blog.writer,
                                    style: themeData.textTheme.subtitle1),
                                Row(
                                  children: [
                                    Text(blog.views,
                                        style: themeData
                                            .textTheme.subtitle1),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(
                                      Icons.remove_red_eye_sharp,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  // blog post text
                  SizedBox(
                      width: size.width / 2.6,
                      child: Text(
                        blog.title,
                        maxLines: 2,
                        // textAlign: TextAlign.justify,
                        overflow: TextOverflow.ellipsis,
                      ))
                ],
              ),
            );
          }),
    );
  }
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

class HomePageTagList extends StatelessWidget {
  const HomePageTagList({
    Key? key,
    required this.bodyMargin,
    required this.themeData,
  }) : super(key: key);

  final double bodyMargin;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
          itemCount: tagList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final tag = tagList[index];
            return Padding(
              padding:
                  EdgeInsets.fromLTRB(8, 17, index == 0 ? bodyMargin : 8, 17),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: GradiantColors.tags,
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft),
                    borderRadius: BorderRadius.circular(18)),
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
    );
  }
}

class HomePagePoster extends StatelessWidget {
  const HomePagePoster({
    Key? key,
    required this.size,
    required this.themeData,
  }) : super(key: key);

  final Size size;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
    );
  }
}
