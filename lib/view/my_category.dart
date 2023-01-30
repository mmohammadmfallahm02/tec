import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tec/Common/my_component.dart';
import 'package:tec/constants/my_color.dart';
import 'package:tec/constants/my_strings.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/models/fake_data.dart';

class MyCategory extends StatefulWidget {
  const MyCategory({super.key});

  @override
  State<MyCategory> createState() => _MyCategoryState();
}

class _MyCategoryState extends State<MyCategory> {
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
              Assets.images.tcbot.path,
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
                    .apply(color: SolidColors.primaryColor)),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
                height: 115,
                child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: tagList.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.35,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedTagList.add(tagList[index]);
                            });
                          },
                          child: MainTags(
                            themeData: themeData,
                            tag: tagList[index],
                            isCategoryList: true,
                          ),
                        ))),
            const SizedBox(
              height: 16,
            ),
            Assets.icons.downCategoryArrow.image(scale: 2.5),
            const SizedBox(
              height: 26,
            ),
            SizedBox(
                height: 115,
                child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: selectedTagList.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.35,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) => Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: SolidColors.surfaceColor,
                              borderRadius: BorderRadius.circular(18)),
                          height: 55,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedTagList[index].title,
                                  style: themeData.textTheme.headline4,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedTagList.removeAt(index);
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 4),
                                    child: Icon(
                                      CupertinoIcons.delete,
                                      color: SolidColors.textColor
                                          .withOpacity(0.5),
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))),
            const SizedBox(
              height: 48,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size(150, 45)),
                ),
                onPressed: () {},
                child: const Text('ادامه'))
          ]),
        ),
      )),
    );
  }
}
