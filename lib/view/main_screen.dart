import 'package:flutter/material.dart';
import 'package:tec/constants/my_color.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/view/home_screen.dart';
import 'package:tec/view/profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double bodyMargin = size.width / 16;
    final ThemeData themeData = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: SolidColors.scaffoldBg,
        elevation: 0,
        title: _appBar(bodyMargin, size),
      ),
      body: Stack(
        children: [
          Center(
            child: Positioned.fill(
                child: ProfileScreen(
                    size: size, themeData: themeData, bodyMargin: bodyMargin)),
          ),
          _bottomNavigation(size, bodyMargin),
        ],
      ),
    ));
  }

  Widget _bottomNavigation(Size size, double bodyMargin) {
    return Positioned(
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
          padding:
              EdgeInsets.fromLTRB(bodyMargin * 1.5, 10, bodyMargin * 1.5, 10),
          child: Container(
            height: size.height / 8,
            decoration: BoxDecoration(
                gradient:
                    const LinearGradient(colors: GradiantColors.bottomNav),
                borderRadius: BorderRadius.circular(26)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(onPressed: () {}, icon: Assets.icons.home.image()),
                  IconButton(
                      onPressed: () {}, icon: Assets.icons.write.image()),
                  IconButton(onPressed: () {}, icon: Assets.icons.user.image()),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _appBar(double bodyMargin, Size size) {
    return Padding(
      padding: EdgeInsets.fromLTRB(bodyMargin * 0.6, 16, bodyMargin * 0.6, 16),
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
