import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tec/constant/my_color.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/route_manager/names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3))
        .then((value) => Get.offAndToNamed(NamedRoute.routeMainScreen));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Assets.images.logo.image(height: 64)),
            const SizedBox(
              height: 32,
            ),
            const SpinKitFadingCube(
              color: SolidColors.primaryColor,
              size: 32,
            )
          ],
        ),
      ),
    );
  }
}
