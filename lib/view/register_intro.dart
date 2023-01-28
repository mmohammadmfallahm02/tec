import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tec/constants/my_strings.dart';
import 'package:tec/gen/assets.gen.dart';

class RegisterIntro extends StatelessWidget {
  const RegisterIntro({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.images.tcbot,
                height: 100,
              ),
              const SizedBox(
                height: 24,
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: MyStrings.welcome,
                      style: themeData.textTheme.headline4)),
              const SizedBox(
                height: 70,
              ),
              SizedBox(
                height: 45,
                width: 150,
                child: ElevatedButton(
                  clipBehavior: Clip.none,
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                height: size.height / 3,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32),
                                      topRight: Radius.circular(32),
                                    )),
                                child: Center(
                                    child: SingleChildScrollView(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          MyStrings.insertYourEmail,
                                          style: themeData.textTheme.headline4,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              48, 32, 48, 32),
                                          child: TextField(
                                            textAlign: TextAlign.center,
                                            decoration: InputDecoration(
                                              hintText: 'techblog@gmail.com',
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                              fixedSize:
                                                  MaterialStateProperty.all(
                                                      const Size(150, 45)),
                                            ),
                                            onPressed: () {},
                                            child: const Text('ادامه'))
                                      ]),
                                )),
                              ),
                            ));
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(150, 45)),
                  ),
                  child: const Text(
                    'بزن بریم ',
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
