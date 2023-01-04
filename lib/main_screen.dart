import 'package:flutter/material.dart';
import 'package:tec/constants/my_color.dart';
import 'package:tec/gen/assets.gen.dart';

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
                      image: (Assets.images.posterTest.image()).image),
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
                              'ملیکا عزیزی - یک روز پیش',
                              style: themeData.textTheme.subtitle1,
                            ),
                            Text('Like 253',
                                style: themeData.textTheme.subtitle1)
                          ]),
                          const SizedBox(height: 8,),
                      Text(
                        'دوازده قدم برنامه نویسی یک دوره ی...س',
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
