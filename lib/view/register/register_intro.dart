import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_strings.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/view/my_category.dart';
// import 'package:validators/validators.dart';

class RegisterIntro extends StatelessWidget {
  RegisterIntro({super.key});

  RegisterController registerController = Get.put(RegisterController());

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
                Assets.images.tcbot.path,
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
                    _showEmailBottomSheet(context, size, themeData);
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

  Future<dynamic> _showEmailBottomSheet(
      BuildContext context, Size size, ThemeData themeData) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          MyStrings.insertYourEmail,
                          style: themeData.textTheme.headline4,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(48, 32, 48, 32),
                          child: TextField(
                            controller: registerController.emailController,
                            onChanged: (value) {
                              // print('is Email ${isEmail(value)}');
                            },
                            style: themeData.textTheme.subtitle2,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: 'techblog@gmail.com',
                            ),
                          ),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  const Size(150, 45)),
                            ),
                            onPressed: () async{
                              registerController.register();
                              Navigator.pop(context);
                              _activateCodeBottomSheet(
                                  context, size, themeData);
                            },
                            child: const Text('ادامه'))
                      ]),
                )),
              ),
            ));
  }

  Future<dynamic> _activateCodeBottomSheet(
      BuildContext context, Size size, ThemeData themeData) {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          MyStrings.insertActivateCode,
                          style: themeData.textTheme.headline4,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(48, 32, 48, 32),
                          child: TextField(
                            controller: registerController.activeCodeController,
                            onChanged: (value) {},
                            style: themeData.textTheme.subtitle2,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: '******',
                            ),
                          ),
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  const Size(150, 45)),
                            ),
                            onPressed: () async{
                              registerController.verify();
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const MyCategory()));
                            },
                            child: const Text('ادامه'))
                      ]),
                )),
              ),
            ));
  }
}
