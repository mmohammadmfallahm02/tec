import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tec/constants/my_color.dart';
import 'package:tec/constants/my_strings.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/models/data_models.dart';
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
      appBar: AppBar(
        backgroundColor: SolidColors.scaffoldBg,
        elevation: 0,
        title: HomeAppBar(bodyMargin: bodyMargin, size: size),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 26,
                ),
                // poster
                HomePoster(size: size, themeData: themeData),
                const SizedBox(
                  height: 32,
                ),
                // tag list
                TagList(bodyMargin: bodyMargin, themeData: themeData),
                // see more
                SeeMore(
                  bodyMargin: bodyMargin,
                  themeData: themeData,
                  icon: Assets.icons.bluePen.image().image,
                  title: MyStrings.viewHotestBlog,
                ),
                // blog list
                BlogList(size: size, bodyMargin: bodyMargin, themeData: themeData),
                SeeMore(
                  bodyMargin: bodyMargin,
                  themeData: themeData,
                  icon: Assets.icons.microphon.image().image,
                  title: MyStrings.viewHotestPodCasts,
                ),
                PodcastList(
                    size: size, bodyMargin: bodyMargin, themeData: themeData),
              ],
            ),
          ),
           Positioned(
            bottom: 0,
            right: 0,
            left: 0,
             child: Container(
                   height: size.height / 10,
                   decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: GradiantColors.bottomNavBackground,
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter)),
                   child: Padding(
                     padding: const EdgeInsets.fromLTRB(48, 8, 48, 8),
                     child: Container(
                     
              height: size.height / 8,
              decoration:  BoxDecoration(
                  gradient: const LinearGradient(colors: GradiantColors.bottomNav),
                  borderRadius: BorderRadius.circular(16)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                IconButton(onPressed: () {}, icon: Assets.icons.home.image()),
                IconButton(onPressed: () {}, icon: Assets.icons.write.image()),
                IconButton(onPressed: () {}, icon: Assets.icons.user.image()),
              ]),
                     ),
                   ),
                 ),
           ),
        ],
      ),
     
    ));
  }
}

class PodcastList extends StatelessWidget {
  const PodcastList(
      {super.key,
      required this.size,
      required this.bodyMargin,
      required this.themeData});
  final Size size;
  final double bodyMargin;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height / 4.5,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  EdgeInsets.fromLTRB(4, 8, index == 0 ? bodyMargin : 16, 8),
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

class BlogList extends StatelessWidget {
  const BlogList({
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
              padding:
                  EdgeInsets.fromLTRB(4, 8, index == 0 ? bodyMargin : 16, 8),
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(blog.writer,
                                    style: themeData.textTheme.subtitle1),
                                Row(
                                  children: [
                                    Text(blog.views,
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
  final ImageProvider<Object> icon;
  final String title;
  const SeeMore({
    Key? key,
    required this.bodyMargin,
    required this.themeData,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final double bodyMargin;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: bodyMargin, top: 25, bottom: 8),
      child: Row(
        children: [
          ImageIcon(
            icon,
            color: SolidColors.seeMore,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(title, style: themeData.textTheme.headline3),
        ],
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    Key? key,
    required this.bodyMargin,
    required this.size,
  }) : super(key: key);

  final double bodyMargin;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(bodyMargin, 16, bodyMargin, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageIcon(
            Assets.icons.menu.image().image,
            size: 26,
            color: Colors.black,
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

class HomePoster extends StatelessWidget {
  const HomePoster({
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
        forgroundPosteritem()
      ],
    );
  }

  Widget forgroundPosteritem() {
    return Positioned(
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
        ));
  }
}

class TagList extends StatelessWidget {
  const TagList({
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
            return tagItem(index, tag);
          }),
    );
  }

  Widget tagItem(int index, HashTagModel tag) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 17, index == 0 ? bodyMargin : 8, 17),
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
  }
}
