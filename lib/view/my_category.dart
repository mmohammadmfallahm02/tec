import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tec/constants/my_color.dart';
import 'package:tec/constants/my_strings.dart';
import 'package:tec/gen/assets.gen.dart';

class MyCategory extends StatelessWidget {
  const MyCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final bodyMargin = MediaQuery.of(context).size.height / 16;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                  text: MyStrings.successfulRegistration,
                  style: themeData.textTheme.headline4!
                      .apply(color: SolidColors.primaryColor)),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(bodyMargin, 32, bodyMargin, 64),
              child: TextField(
                onChanged: (value) {
                  // print('is Email ${isEmail(value)}');
                },
                style: themeData.textTheme.subtitle2,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  hintText: 'نام و نام خانوادگی',
                ),
              ),
            ),
            Text(MyStrings.chooseCategory,
                style: themeData.textTheme.headline4!
                    .apply(color: SolidColors.primaryColor))
          ]),
        ),
      )),
    );
  }
}
