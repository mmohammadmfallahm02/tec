import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tec/constants/my_color.dart';
import 'package:tec/constants/my_strings.dart';
import 'package:tec/gen/assets.gen.dart';

class RegisterIntro extends StatelessWidget {
  const RegisterIntro({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.images.tcbot,
              height: 100,
            ),
            const SizedBox(
              height: 16,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: MyStrings.welcome,
                    style: themeData.textTheme.headline4)),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                textStyle: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return themeData.textTheme.headline1;
                    }
                    return themeData.textTheme.subtitle1;
                  },
                ),
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return SolidColors.seeMore;
                    }
                    return SolidColors.primaryColor;
                  },
                ),
              ),
              child: const Text(
                'بزن بریم ',
              ),
            )
          ],
        ),
      )),
    );
  }
}
