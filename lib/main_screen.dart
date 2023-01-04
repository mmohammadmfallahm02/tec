import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tec/constants/my_color.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/models/fake_data.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.menu),
                Assets.images.logo.image(height: size.height / 13.6),
                const Icon(Icons.search)
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                width: size.width / 1.13,
                height: size.height / 4.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                      fit: BoxFit.cover,
<<<<<<< HEAD
                      image: AssetImage(homePagePosterMap['ImageAssets'])),
=======
                      image: (Assets.images.posterTest.image()).image),
>>>>>>> 59b7393e6ebf945eafb11313934b545f4054c12c
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
                  left: 0,
                  right: 0,
                  bottom: 16,
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
<<<<<<< HEAD
                              "${homePagePosterMap["writer"]}  -  ${homePagePosterMap["date"]}",
                              style: themeData.textTheme.subtitle1,
                            ),
                            Row(
                              children: [
                                
                                Text(homePagePosterMap["view"],
                                    style: themeData.textTheme.subtitle1),
                                    const SizedBox(width: 8,),
                                    const Icon(Icons.remove_red_eye_sharp,color: Colors.white,size: 16,),
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
                        textAlign:TextAlign.center,
=======
                              'ملیکا عزیزی - یک روز پیش',
                              style: themeData.textTheme.subtitle1,
                            ),
                            Text('Like 253',
                                style: themeData.textTheme.subtitle1)
                          ]),
                          const SizedBox(height: 8,),
                      Text(
                        'دوازده قدم برنامه نویسی یک دوره ی...س',
>>>>>>> 59b7393e6ebf945eafb11313934b545f4054c12c
                        style: themeData.textTheme.headline1,
                      )
                    ],
                  ))
            ],
          ),
        ],
      ),
    ));
  }
}
